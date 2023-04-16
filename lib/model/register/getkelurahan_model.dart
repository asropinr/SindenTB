class GetKelurahan {
  int? status;
  String? message;
  List<Data>? data;

  GetKelurahan({this.status, this.message, this.data});

  GetKelurahan.fromJson(Map<String, dynamic> json) {
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
  String? idKel;
  String? idKec;
  String? nama;

  Data({this.idKel, this.idKec, this.nama});

  Data.fromJson(Map<String, dynamic> json) {
    idKel = json['id_kel'];
    idKec = json['id_kec'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_kel'] = idKel;
    data['id_kec'] = idKec;
    data['nama'] = nama;
    return data;
  }
}
