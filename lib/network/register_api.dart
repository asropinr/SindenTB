import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sinden_tb_app/constan/endpoint.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/helper/check_internet.dart';
import 'package:sinden_tb_app/helper/logger_printer.dart';
import 'package:sinden_tb_app/helper/network_response.dart';
import 'package:dio/dio.dart' as dio;

var _log = Logger(
  printer: SimpleLogPrinter("TO Api"),
);

class RegistrasiApi {
  Future<Dio> _normal({int? timeout, String? token}) async {
    String uri = Endpoint.baseUrl;

    _log.d(uri);
    final tokenn = await Prefence().getToken();
    _log.d("INI TOKEN $tokenn");
    BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.json,
      connectTimeout: Duration(seconds: timeout ?? 60000),
      receiveTimeout: Duration(seconds: timeout ?? 60000),
      headers: {
        "Content-Type": "application/json",
        "X-API-KEY": Endpoint.apiKey,
        if (tokenn != null) "Authorization": "Bearer $tokenn",
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
    final dio = await _normal(timeout: timeout, token: token);
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
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
        e.response.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      return NetworkResponse.internetError();
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      return NetworkResponse.error();
    }
  }

  Future<NetworkResponse> _postRequest(
      {path, body, onSendProgress, timeout}) async {
    try {
      final dio = await _normal(timeout: timeout);

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

      final res = await dio.post(
        path,
        data: body,
        onSendProgress: onSendProgress,
      );
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
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
        "Terjadi Kesalahan1",
        e.response.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      print(e);
      return NetworkResponse.error();
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

  Future<NetworkResponse> getProvinsi() async {
    final res = await _getRequest(
      path: Endpoint.getProvinsi,
    );
    return res;
  }

  Future<NetworkResponse> getKabupaten(idProv) async {
    final res = await _getRequest(
      path: Endpoint.getKabupaten,
      params: {
        "id_prov": idProv,
      },
    );
    return res;
  }

  Future<NetworkResponse> getKecamatan(idKab) async {
    final res = await _getRequest(
      path: Endpoint.getKecamatan,
      params: {
        "id_kab": idKab,
      },
    );
    return res;
  }

  Future<NetworkResponse> getKelurahan(idKec) async {
    final res = await _getRequest(
      path: Endpoint.getKelurahan,
      params: {
        "id_kel": idKec,
      },
    );
    return res;
  }

  Future<NetworkResponse> postRegister(payload) async {
    final res = await _postRequest(
      path: Endpoint.registerUser,
      body: payload,
    );
    return res;
  }

  Future<NetworkResponse> postLogin(email, password) async {
    final res = await _postRequest(
      path: Endpoint.login,
      body: {
        "user_email": email,
        "password": password,
      },
    );
    return res;
  }

  Future<NetworkResponse> getPuskesmas(kabupaten) async {
    final res = await _getRequest(
      path: Endpoint.getPuskesmasByKota,
      params: {
        "kabupaten": kabupaten,
      },
    );
    return res;
  }

  Future<NetworkResponse> postUpdateProfile(
      userName,
      userEmail,
      userPhone,
      userAddres,
      userUniversity,
      dob,
      idProv,
      idKab,
      idKec,
      idKel,
      foto,
      puskesmas,
      gender) async {
    final res = await _postRequest(
      path: Endpoint.updateProfile,
      body: {
        "user_name": userName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_address": userAddres,
        "user_university": userUniversity,
        "dob": DateFormat(
          "y-MM-d",
        ).format(
          dob,
        ),
        "u_provinsi_id": idProv,
        "u_kabupaten_id": idKab,
        "u_kecamatan_id": idKec,
        "u_kelurahan_id": idKel,
        if (foto != null)
          "foto": await dio.MultipartFile.fromFile(foto,
              filename: foto.split("/").last),
        "user_puskesmas": puskesmas,
        "gender": gender,
      },
    );
    return res;
  }

  Future<NetworkResponse> postResetPasssword(email) async {
    final res = await _postRequest(
      path: Endpoint.resetPassword,
      body: {
        "user_email": email,
      },
    );
    return res;
  }
}
