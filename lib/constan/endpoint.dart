class Endpoint {
  static const String baseUrl = "https://api.sindentb.com/";
  static const String apiKey =
      "Jx556670l7cDeI39ICC6FO1CeJ0UssS6JQyJrImtE0ByAL7pNJBL0Phi8znEk20nXAmpxcK";

  static const String getProvinsi = "users/prov";
  static const String getKabupaten = "users/kab";
  static const String getKecamatan = "users/kec";
  static const String getKelurahan = "users/kel";
  static const String registerUser = "users/registrasi";
  static const String login = "users/login";
  static const String updateProfile = "users/update_profile";
  static const String resetPassword = "users/reset_password";

  static const String getPuskesmasByKota = "puskesmas/puskesmas_kab";
  static const String getListPuskesmasBylongLat = "puskesmas/terdekat";

  static const String getArtikel = "artikel";
  static const String getEdukasiTb = "artikel/edukasi_tb";
  static const String getTenatngKami = "artikel/about_us";

  static const String getPsp = "artikel/psp";
  static const String getpersetujuan = "artikel/lembar_persetujuan";
  static const String getSoalSkrining = "skrining";
  static const String postJawwaban = "skrining/answer";
  static const String getHistory = "skrining/history";

  static const String getDetail = "skrining/result_skrining";
}
