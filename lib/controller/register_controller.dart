import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:sinden_tb_app/constan/const.dart';
import 'package:sinden_tb_app/model/register/getKecamatan_model.dart';
import 'package:sinden_tb_app/model/artikel/getListPuskesmasbylongLat_model.dart';
import 'package:sinden_tb_app/model/register/getPuskesmas_byKota_model.dart';
import 'package:sinden_tb_app/model/register/getkebaputen_model.dart';
import 'package:sinden_tb_app/model/register/getkelurahan_model.dart';
import 'package:sinden_tb_app/model/register/getprovinsi_model.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';
import 'package:sinden_tb_app/model/register/postregister_model.dart';
import 'package:sinden_tb_app/model/register/postupdateprofile_model.dart';
import 'package:sinden_tb_app/network/register_api.dart';

class RegisterController extends GetxController {
  GetProvinsi? getProvinsi;
  GetKabupaten? getKabupaten;
  GetKecamatan? getKecamatan;
  GetKelurahan? getKelurahan;
  GetPuskesmas? getPuskesmas;
  PostRegister? postRegister;
  PostLogin? postLogin;
  PostUpdateProfile? postUpdateProfile;

  final api = RegistrasiApi();

  String? idProv;
  String? idKab;
  String? idKec;
  String? idKel;
  String? puskesmas;
  String? kabupaten;
  bool isLainnya = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController asalSekolah = TextEditingController();
  TextEditingController noWa = TextEditingController();
  TextEditingController alamatLengkap = TextEditingController();
  TextEditingController alamatPuskesmas = TextEditingController();
  DateTime? selectedDate;
  String jenisKelamin = "laki-laki";

  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();

  XFile? pathImage;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // <- Reduce Image quality
      maxHeight: 500, // <- reduce the image size
      maxWidth: 500,
    );
    if (image != null) {
      pathImage = image;

      update();
    }
  }

  setKabupaten() async {
    for (var element in getKabupaten!.data!) {
      if (element.idKab == idKab) {
        kabupaten = element.namaKab;
      }
    }
  }

  getListProvinsi() async {
    getProvinsi = null;
    update();
    final res = await api.getProvinsi();
    if (res.status == Status.success) {
      getProvinsi = GetProvinsi.fromJson(res.data!);
    }
  }

  getListKabupaten(String idProv) async {
    getKabupaten = null;
    update();
    final res = await api.getKabupaten(idProv);
    if (res.status == Status.success) {
      getKabupaten = GetKabupaten.fromJson(res.data!);
    }
  }

  getListKecamatan(String idKab) async {
    getKecamatan = null;
    update();
    final res = await api.getKecamatan(idKab);
    if (res.status == Status.success) {
      getKecamatan = GetKecamatan.fromJson(res.data!);
    }
  }

  getListKelurahan(String idKec) async {
    getKelurahan = null;
    update();
    final res = await api.getKelurahan(idKec);
    if (res.status == Status.success) {
      getKelurahan = GetKelurahan.fromJson(res.data!);
    }
  }

  getListPuskesmasByKota() async {
    getPuskesmas = null;
    update();
    final res = await api.getPuskesmas(kabupaten);
    if (res.status == Status.success) {
      getPuskesmas = GetPuskesmas.fromJson(res.data!);
    }
  }

  postDataRegister(payload) async {
    postRegister = null;
    update();
    final res = await api.postRegister(payload);
    if (res.status == Status.success) {
      postRegister = PostRegister.fromJson(res.data!);
    }
  }

  postDataLogin() async {
    postLogin = null;
    update();
    final res = await api.postLogin(emailLogin.text, passwordLogin.text);
    if (res.status == Status.success) {
      postLogin = PostLogin.fromJson(res.data!);
    }
  }

  postUpdate(payload) async {
    postLogin = null;
    update();
    final res = await api.postUpdateProfile(payload);
    if (res.status == Status.success) {
      postLogin = PostLogin.fromJson(res.data!);
    }
  }
}
