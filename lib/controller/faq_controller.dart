import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sinden_tb_app/constan/const.dart';
import 'package:sinden_tb_app/model/pusatbantuan/get_chatbox_model.dart';
import 'package:sinden_tb_app/model/pusatbantuan/list_faq_model.dart';
import 'package:sinden_tb_app/network/faq_api.dart';

class FaqController extends GetxController {
  final api = FaqApi();

  GetListFaq? getListFaq;
  GetChatBoxModel? getChatBoxModel;

  getFaqList() async {
    getListFaq = null;
    update();
    final res = await api.getFaqList();
    if (res.status == Status.success) {
      getListFaq = GetListFaq.fromJson(res.data!);
    }
  }

  getChatBox(parentId) async {
    getChatBoxModel = null;
    update();
    final res = await api.getChatBox(parentId);
    if (res.status == Status.success) {
      getChatBoxModel = GetChatBoxModel.fromJson(res.data!);
    }
  }
}
