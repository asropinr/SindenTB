class PostJawabanSkrining {
  int? status;
  String? message;
  Data? data;

  PostJawabanSkrining({this.status, this.message, this.data});

  PostJawabanSkrining.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? resultText;
  String? questionKey;
  String? resultTextColor;
  String? resultImage;
  String? questionFk;
  String? questionFkText;
  String? questionFkAnswer;
  String? statusResponden;

  Data(
      {this.resultText,
      this.questionKey,
      this.resultTextColor,
      this.resultImage,
      this.questionFk,
      this.questionFkText,
      this.questionFkAnswer,
      this.statusResponden});

  Data.fromJson(Map<String, dynamic> json) {
    resultText = json['result_text'];
    questionKey = json['question_key'];
    resultTextColor = json['result_text_color'];
    resultImage = json['result_image'];
    questionFk = json['question_fk'];
    questionFkText = json['question_fk_text'];
    questionFkAnswer = json['question_fk_answer'];
    statusResponden = json['status_responden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result_text'] = resultText;
    data['question_key'] = questionKey;
    data['result_text_color'] = resultTextColor;
    data['result_image'] = resultImage;
    data['question_fk'] = questionFk;
    data['question_fk_text'] = questionFkText;
    data['question_fk_answer'] = questionFkAnswer;
    data['status_responden'] = statusResponden;
    return data;
  }
}
