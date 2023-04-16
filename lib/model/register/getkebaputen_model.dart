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
  String? idKab;
  String? idProvFk;
  String? namaKab;

  Data({this.idKab, this.idProvFk, this.namaKab});

  Data.fromJson(Map<String, dynamic> json) {
    idKab = json['id_kab'];
    idProvFk = json['id_prov_fk'];
    namaKab = json['nama_kab'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_kab'] = idKab;
    data['id_prov_fk'] = idProvFk;
    data['nama_kab'] = namaKab;
    return data;
  }
}
