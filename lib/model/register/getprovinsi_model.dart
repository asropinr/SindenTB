class GetProvinsi {
  int? status;
  String? message;
  List<Data>? data;

  GetProvinsi({this.status, this.message, this.data});

  GetProvinsi.fromJson(Map<String, dynamic> json) {
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
  String? idProv;
  String? nama;

  Data({this.idProv, this.nama});

  Data.fromJson(Map<String, dynamic> json) {
    idProv = json['id_prov'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_prov'] = idProv;
    data['nama'] = nama;
    return data;
  }
}
