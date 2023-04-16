class GetEdukasiTb {
  int? status;
  String? message;
  Data? data;

  GetEdukasiTb({this.status, this.message, this.data});

  GetEdukasiTb.fromJson(Map<String, dynamic> json) {
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
  String? eduTbTitle;
  String? eduTbText;

  Data({this.eduTbTitle, this.eduTbText});

  Data.fromJson(Map<String, dynamic> json) {
    eduTbTitle = json['edu_tb_title'];
    eduTbText = json['edu_tb_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['edu_tb_title'] = eduTbTitle;
    data['edu_tb_text'] = eduTbText;
    return data;
  }
}
