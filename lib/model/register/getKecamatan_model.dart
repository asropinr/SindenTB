class GetKecamatan {
  int? status;
  String? message;
  List<Data>? data;

  GetKecamatan({this.status, this.message, this.data});

  GetKecamatan.fromJson(Map<String, dynamic> json) {
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
  String? cityCode;
  String? name;
  String? code;
  Data({
    this.id,
    this.cityCode,
    this.name,
    this.code,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityCode = json['city_code'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_code'] = this.cityCode;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
