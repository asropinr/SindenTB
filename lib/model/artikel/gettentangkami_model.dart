class GetTentangKami {
  int? status;
  String? message;
  Data? data;

  GetTentangKami({this.status, this.message, this.data});

  GetTentangKami.fromJson(Map<String, dynamic> json) {
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
  String? aboutTitle;
  String? aboutText;

  Data({this.aboutTitle, this.aboutText});

  Data.fromJson(Map<String, dynamic> json) {
    aboutTitle = json['about_title'];
    aboutText = json['about_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about_title'] = aboutTitle;
    data['about_text'] = aboutText;
    return data;
  }
}
