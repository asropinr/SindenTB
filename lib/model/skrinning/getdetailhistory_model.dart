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
  List<Citations>? citations;

  Data(
      {this.resultText,
      this.questionKey,
      this.resultTextColor,
      this.resultImage,
      this.statusResponden,
      this.citations});

  Data.fromJson(Map<String, dynamic> json) {
    resultText = json['result_text'];
    questionKey = json['question_key'];
    resultTextColor = json['result_text_color'];
    resultImage = json['result_image'];
    statusResponden = json['status_responden'];
    if (json['citations'] != null) {
      citations = <Citations>[];
      json['citations'].forEach((v) {
        citations!.add(Citations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result_text'] = resultText;
    data['question_key'] = questionKey;
    data['result_text_color'] = resultTextColor;
    data['result_image'] = resultImage;
    data['status_responden'] = statusResponden;
    if (citations != null) {
      data['citations'] = citations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Citations {
  String? id;
  String? code;
  String? title;
  String? publisher;
  String? sectionRef;
  String? fileUrl;

  Citations(
      {this.id,
      this.code,
      this.title,
      this.publisher,
      this.sectionRef,
      this.fileUrl});

  Citations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    title = json['title'];
    publisher = json['publisher'];
    sectionRef = json['section_ref'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['title'] = title;
    data['publisher'] = publisher;
    data['section_ref'] = sectionRef;
    data['file_url'] = fileUrl;
    return data;
  }
}
