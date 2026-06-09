class GetSoalSkrining {
  int? status;
  String? message;
  List<Data>? data;

  GetSoalSkrining({this.status, this.message, this.data});

  GetSoalSkrining.fromJson(Map<String, dynamic> json) {
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
  int? questionId;
  String? questionOrder;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? jawaban;

  Data({
    this.questionId,
    this.questionOrder,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.jawaban,
  });

  Data.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionOrder = json['question_order'];
    question = json['question'];
    option1 = json['option_1'];
    option2 = json['option_2'];
    option3 = json['option_3'] ?? "";
    jawaban = "X";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['question_order'] = questionOrder;
    data['question'] = question;
    data['option_1'] = option1;
    data['option_2'] = option2;
    data['option_3'] = option3;
    return data;
  }
}
