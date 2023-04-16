import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sinden_tb_app/constan/const.dart';
import 'package:sinden_tb_app/model/artikel/getListPuskesmasbylongLat_model.dart';
import 'package:sinden_tb_app/model/artikel/getartikel_model.dart';
import 'package:sinden_tb_app/model/artikel/getedukasi_model.dart';
import 'package:sinden_tb_app/model/artikel/gettentangkami_model.dart';
import 'package:sinden_tb_app/network/artikel_api.dart';

class ArtikelController extends GetxController {
  final api = ArtikelApi();

  GetArtikel? getArtikel;
  GetEdukasiTb? getEdukasiTb;
  GetListPuskesmaslonglat? getListPuskesmaslonglat;
  GetTentangKami? getTentangKami;

  getListArtikel() async {
    getArtikel = null;
    update();
    final res = await api.getArtikel();
    if (res.status == Status.success) {
      getArtikel = GetArtikel.fromJson(res.data!);
    }
  }

  getEdukasi() async {
    getEdukasiTb = null;
    update();
    final res = await api.getEdukasiTB();
    if (res.status == Status.success) {
      getEdukasiTb = GetEdukasiTb.fromJson(res.data!);
    }
  }

  getListPusLongLat(String lat, String long) async {
    getListPuskesmaslonglat = null;
    update();
    final res = await api.getListPuskesmasByLongLat(lat, long);
    if (res.status == Status.success) {
      getListPuskesmaslonglat = GetListPuskesmaslonglat.fromJson(res.data!);
    }
  }

  getTentang() async {
    getTentangKami = null;
    update();
    final res = await api.getTentangKami();
    if (res.status == Status.success) {
      getTentangKami = GetTentangKami.fromJson(res.data!);
    }
  }
}
