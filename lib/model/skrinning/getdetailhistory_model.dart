class GetDetailHistory {
  int? status;
  String? message;
  Data? data;

  GetDetailHistory({this.status, this.message, this.data});

  GetDetailHistory.fromJson(Map<String, dynamic> json) {
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
  String? statusResponden;

  Data(
      {this.resultText,
      this.questionKey,
      this.resultTextColor,
      this.resultImage,
      this.statusResponden});

  Data.fromJson(Map<String, dynamic> json) {
    resultText = json['result_text'];
    questionKey = json['question_key'];
    resultTextColor = json['result_text_color'];
    resultImage = json['result_image'];
    statusResponden = json['status_responden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result_text'] = resultText;
    data['question_key'] = questionKey;
    data['result_text_color'] = resultTextColor;
    data['result_image'] = resultImage;
    data['status_responden'] = statusResponden;
    return data;
  }
}
