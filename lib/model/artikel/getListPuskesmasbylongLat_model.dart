class GetListPuskesmaslonglat {
  int? status;
  String? message;
  List<Data>? data;

  GetListPuskesmaslonglat({this.status, this.message, this.data});

  GetListPuskesmaslonglat.fromJson(Map<String, dynamic> json) {
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
  String? puskesmasId;
  String? nama;
  String? provinsi;
  String? kabupaten;
  String? alamat;
  String? latitude;
  String? longitude;
  String? distance;

  Data(
      {this.puskesmasId,
      this.nama,
      this.provinsi,
      this.kabupaten,
      this.alamat,
      this.latitude,
      this.longitude,
      this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    puskesmasId = json['puskesmas_id'];
    nama = json['nama'];
    provinsi = json['provinsi'];
    kabupaten = json['kabupaten'];
    alamat = json['alamat'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['puskesmas_id'] = puskesmasId;
    data['nama'] = nama;
    data['provinsi'] = provinsi;
    data['kabupaten'] = kabupaten;
    data['alamat'] = alamat;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance'] = distance;
    return data;
  }
}
