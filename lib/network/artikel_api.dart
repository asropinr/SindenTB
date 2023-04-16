import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sinden_tb_app/constan/endpoint.dart';
import 'package:sinden_tb_app/helper/check_internet.dart';
import 'package:sinden_tb_app/helper/logger_printer.dart';
import 'package:sinden_tb_app/helper/network_response.dart';

var _log = Logger(
  printer: SimpleLogPrinter("TO Api"),
);

class ArtikelApi {
  Dio _normal({int? timeout, String? token}) {
    String uri = Endpoint.baseUrl;

    _log.d(uri);
    BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.json,
      connectTimeout: Duration(seconds: timeout ?? 60000),
      receiveTimeout: Duration(seconds: timeout ?? 60000),
      headers: {
        "Content-Type": "application/json",
        "X-API-KEY": Endpoint.apiKey,
      },

      // ignore: missing_return
      // validateStatus: (code) {
      //   if (code >= 200) {
      //     return true;
      //   }
      // },
    );
    Dio dio = Dio(options);
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    return dio;
  }

  Future<NetworkResponse> _getRequest(
      {required String path, params, timeout, token}) async {
    final dio = _normal(timeout: timeout, token: token);
    try {
      final internet = await CheckInternetConnection.check();
      if (!internet) {
        Get.snackbar(
          "Tidak ada koneksi",
          "Pastikan internet anda aktif.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          dismissDirection: DismissDirection.horizontal,
        );
        return NetworkResponse.internetError();
      }

      final res = await dio.get(path, queryParameters: params);
      _log.d(res.statusCode);
      _log.d(res.data);
      _log.d(res.data is String);
      _log.d(res.statusMessage);

      return NetworkResponse.success(data: res.data);
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Request Timeout",
        "Silahkan ulangi beberapa saat lagi",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      return NetworkResponse.timeout();
    } on SocketException catch (_) {
      Get.snackbar(
        "Masalah Koneksi",
        "Terjadi masalah pada koneksi internet.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      return NetworkResponse.internetError();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        Get.snackbar(
          "Request Timeout",
          "Silahkan ulangi beberapa saat lagi",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          dismissDirection: DismissDirection.horizontal,
        );
        return NetworkResponse.timeout();
      }

      Get.snackbar(
        "Masalah Koneksi",
        "Terjadi masalah pada koneksi internet.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      return NetworkResponse.internetError();
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Silahkan ulangi beberapa saat lagi",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      return NetworkResponse.error();
    }
  }

  Future<NetworkResponse> getArtikel() async {
    final res = await _getRequest(
      path: Endpoint.getArtikel,
    );
    return res;
  }

  Future<NetworkResponse> getEdukasiTB() async {
    final res = await _getRequest(
      path: Endpoint.getEdukasiTb,
    );
    return res;
  }

  Future<NetworkResponse> getListPuskesmasByLongLat(lat, long) async {
    final res =
        await _getRequest(path: Endpoint.getListPuskesmasBylongLat, params: {
      "lat": lat,
      "long": long,
    });
    return res;
  }

  Future<NetworkResponse> getTentangKami() async {
    final res = await _getRequest(
      path: Endpoint.getTenatngKami,
    );
    return res;
  }
}
