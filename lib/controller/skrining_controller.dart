import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sinden_tb_app/constan/const.dart';
import 'package:sinden_tb_app/model/skrinning/getdetailhistory_model.dart';
import 'package:sinden_tb_app/model/skrinning/gethistory_model.dart';
import 'package:sinden_tb_app/model/skrinning/getpersetujuan_model.dart';
import 'package:sinden_tb_app/model/skrinning/getpsp_model.dart';
import 'package:sinden_tb_app/model/skrinning/getsoal_model.dart';
import 'package:sinden_tb_app/model/skrinning/postjawaban_model.dart';
import 'package:sinden_tb_app/network/skrining_api.dart';

class SkriningController extends GetxController {
  final api = SkriningApi();

  GetPsp? getPsp;
  GetPersetujuan? getPersetujuan;
  GetSoalSkrining? getSoalSkrining;
  PostJawabanSkrining? postJawabanSkrining;
  GetHistory? getHistory;

  GetDetailHistory? getDetailHistory;

  getPspp() async {
    getPsp = null;
    update();
    final res = await api.getPsp();
    if (res.status == Status.success) {
      getPsp = GetPsp.fromJson(res.data!);
    }
  }

  getPersetujuann() async {
    getPersetujuan = null;
    update();
    final res = await api.getPersetujuan();
    if (res.status == Status.success) {
      getPersetujuan = GetPersetujuan.fromJson(res.data!);
    }
  }

  getSoal() async {
    getSoalSkrining = null;
    update();
    final res = await api.getSoalSkrining();
    if (res.status == Status.success) {
      getSoalSkrining = GetSoalSkrining.fromJson(res.data!);
    }
  }

  postJawaban(idUser, questionId, answer) async {
    postJawabanSkrining = null;
    update();
    final res = await api.postJawaban(idUser, questionId, answer);
    if (res.status == Status.success) {
      postJawabanSkrining = PostJawabanSkrining.fromJson(res.data!);
    }
  }

  getHistoryy(idUser) async {
    getHistory = null;
    update();
    final res = await api.getHistory(idUser);
    if (res.status == Status.success) {
      getHistory = GetHistory.fromJson(res.data!);
    }
  }

  getDetail(idUser, scriningId) async {
    getDetailHistory = null;
    update();
    final res = await api.postDetail(idUser, scriningId);
    if (res.status == Status.success) {
      getDetailHistory = GetDetailHistory.fromJson(res.data!);
    }
  }
}
