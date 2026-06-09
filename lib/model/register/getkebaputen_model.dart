class GetKabupaten {
  int? status;
  String? message;
  List<Data>? data;

  GetKabupaten({this.status, this.message, this.data});

  GetKabupaten.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? provinceCode;
  String? name;
  String? code;
  Data({this.id, this.provinceCode, this.name, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceCode = json['province_code'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province_code'] = this.provinceCode;
    data['code'] = this.code;
    return data;
  }
}
