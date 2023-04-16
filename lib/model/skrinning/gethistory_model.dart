class GetHistory {
  int? status;
  String? message;
  List<Data>? data;

  GetHistory({this.status, this.message, this.data});

  GetHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? skriningId;
  String? userFk;
  String? dateCreate;
  String? status;
  String? statusResponden;
  String? priorityResult;
  String? resultText;
  String? questionKey;
  String? resultTextColor;
  String? resultImage;
  String? questionFk;
  String? questionFkText;
  String? questionFkAnswer;

  Data(
      {this.skriningId,
      this.userFk,
      this.dateCreate,
      this.status,
      this.statusResponden,
      this.priorityResult,
      this.resultText,
      this.questionKey,
      this.resultTextColor,
      this.resultImage,
      this.questionFk,
      this.questionFkText,
      this.questionFkAnswer});

  Data.fromJson(Map<String, dynamic> json) {
    skriningId = json['skrining_id'];
    userFk = json['user_fk'];
    dateCreate = json['date_create'];
    status = json['status'];
    statusResponden = json['status_responden'];
    priorityResult = json['priority_result'];
    resultText = json['result_text'];
    questionKey = json['question_key'];
    resultTextColor = json['result_text_color'];
    resultImage = json['result_image'];
    questionFk = json['question_fk'];
    questionFkText = json['question_fk_text'];
    questionFkAnswer = json['question_fk_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skrining_id'] = skriningId;
    data['user_fk'] = userFk;
    data['date_create'] = dateCreate;
    data['status'] = status;
    data['status_responden'] = statusResponden;
    data['priority_result'] = priorityResult;
    data['result_text'] = resultText;
    data['question_key'] = questionKey;
    data['result_text_color'] = resultTextColor;
    data['result_image'] = resultImage;
    data['question_fk'] = questionFk;
    data['question_fk_text'] = questionFkText;
    data['question_fk_answer'] = questionFkAnswer;
    return data;
  }
}
