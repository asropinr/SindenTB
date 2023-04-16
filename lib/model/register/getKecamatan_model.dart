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
  String? idKec;
  String? idKab;
  String? nama;

  Data({this.idKec, this.idKab, this.nama});

  Data.fromJson(Map<String, dynamic> json) {
    idKec = json['id_kec'];
    idKab = json['id_kab'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_kec'] = idKec;
    data['id_kab'] = idKab;
    data['nama'] = nama;
    return data;
  }
}
