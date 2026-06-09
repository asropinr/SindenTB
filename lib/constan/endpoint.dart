class Endpoint {
  static const String baseUrl = "https://sindentb.com/api/v2/";
  static const String apiKey =
      "Jx556670l7cDeI39ICC6FO1CeJ0UssS6JQyJrImtE0ByAL7pNJBL0Phi8znEk20nXAmpxcK";

  static const String getProvinsi = "regions/prov";
  static const String getKabupaten = "regions/kab";
  static const String getKecamatan = "regions/kec";
  static const String getKelurahan = "regions/kel";
  static const String registerUser = "registrasi";
  static const String login = "login";
  static const String profile = "profile";
  static const String updateProfile = "users/update_profile";
  static const String resetPassword = "reset-password";

  static const String getPuskesmasByKota = "puskesmas/puskesmas_kab";
  static const String getListPuskesmasBylongLat = "puskesmas/terdekat";

  static const String getArtikel = "artikel";
  static const String getEdukasiTb = "artikel/edukasi_tb";
  static const String getTenatngKami = "artikel/about_us";

  static const String getPsp = "artikel/psp";
  static const String getpersetujuan = "artikel/lembar_persetujuan";
  static const String getSoalSkrining = "skrining";
  static const String postJawwaban = "skrining/submit";
  static const String getHistory = "skrining/history";

  static const String getDetail = "skrining/result";

  static const String getFaq = "faqs";
  static const String getChatbox = "chat/next-step";
}
