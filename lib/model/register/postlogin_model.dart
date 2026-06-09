class PostLogin {
  int? status;
  String? message;
  String? token;
  Data? data;

  PostLogin({this.status, this.message, this.token, this.data});

  PostLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userRole;
  String? userPhone;
  String? userAddress;
  String? userFoto;
  String? userStatus;
  String? isDeleteUser;
  String? dateCreate;
  String? dateLogin;
  String? userUniversity;
  String? dob;
  String? langitude;
  String? longitude;
  String? uProvinsiId;
  String? uProvinsi;
  String? uKabupatenId;
  String? uKabupaten;
  String? uKecamatanId;
  String? uKecamatan;
  String? uKelurahanId;
  String? uKelurahan;
  String? token;
  String? userPuskesmas;
  String? gender;

  Data(
      {this.userId,
      this.userName,
      this.userPassword,
      this.userEmail,
      this.userRole,
      this.userPhone,
      this.userAddress,
      this.userFoto,
      this.userStatus,
      this.isDeleteUser,
      this.dateCreate,
      this.dateLogin,
      this.userUniversity,
      this.dob,
      this.langitude,
      this.longitude,
      this.uProvinsiId,
      this.uProvinsi,
      this.uKabupatenId,
      this.uKabupaten,
      this.uKecamatanId,
      this.uKecamatan,
      this.uKelurahanId,
      this.uKelurahan,
      this.token,
      this.userPuskesmas,
      this.gender});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userPassword = json['user_password'];
    userEmail = json['user_email'];
    userRole = json['user_role'];
    userPhone = json['user_phone'];
    userAddress = json['user_address'];
    userFoto = json['user_foto'];
    userStatus = json['user_status'];
    isDeleteUser = json['is_delete_user'];
    dateCreate = json['date_create'];
    dateLogin = json['date_login'];
    userUniversity = json['user_university'];
    dob = json['dob'];
    langitude = json['langitude'];
    longitude = json['longitude'];
    uProvinsiId = json['u_provinsi_id'];
    uProvinsi = json['u_provinsi'];
    uKabupatenId = json['u_kabupaten_id'];
    uKabupaten = json['u_kabupaten'];
    uKecamatanId = json['u_kecamatan_id'];
    uKecamatan = json['u_kecamatan'];
    uKelurahanId = json['u_kelurahan_id'];
    uKelurahan = json['u_kelurahan'];
    token = json['token'];
    userPuskesmas = json['user_puskesmas'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_password'] = userPassword;
    data['user_email'] = userEmail;
    data['user_role'] = userRole;
    data['user_phone'] = userPhone;
    data['user_address'] = userAddress;
    data['user_foto'] = userFoto;
    data['user_status'] = userStatus;
    data['is_delete_user'] = isDeleteUser;
    data['date_create'] = dateCreate;
    data['date_login'] = dateLogin;
    data['user_university'] = userUniversity;
    data['dob'] = dob;
    data['langitude'] = langitude;
    data['longitude'] = longitude;
    data['u_provinsi_id'] = uProvinsiId;
    data['u_provinsi'] = uProvinsi;
    data['u_kabupaten_id'] = uKabupatenId;
    data['u_kabupaten'] = uKabupaten;
    data['u_kecamatan_id'] = uKecamatanId;
    data['u_kecamatan'] = uKecamatan;
    data['u_kelurahan_id'] = uKelurahanId;
    data['u_kelurahan'] = uKelurahan;
    data['token'] = token;
    data['user_puskesmas'] = userPuskesmas;
    data['gender'] = gender;
    return data;
  }
}
