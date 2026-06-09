//import 'package:sekolah_kita_guru/model/post_login.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';

class Prefence {
  static String loginData = "login_data";
  static String loginStatus = "login_status";

  Future<SharedPreferences> sharePref() async {
    final sharePref = await SharedPreferences.getInstance();
    return sharePref;
  }

  Future saveString(key, data) async {
    final _pref = await sharePref();
    await _pref.setString(key, data);
  }

  Future<String?> getString(key) async {
    final _pref = await sharePref();
    return _pref.getString(
      key,
    );
  }

  setBoolPrefs(String key, bool value) async {
    final _pref = await sharePref();
    await _pref.setBool(key, value);
  }

  Future<bool?> getBoolPrefs(String key) async {
    final _pref = await sharePref();
    return _pref.getBool(key);
  }

  saveDataLogin(PostLogin? postLogin) async {
    final json = postLogin!.toJson();
    final dataLogin = jsonEncode(json);
    print("Simpan");
    print("INI SIMPAN DATA LOGIN");
    print(dataLogin);
    await saveString(loginData, dataLogin);
  }

  Future<PostLogin> getDataLogin() async {
    final data = await getString(loginData);
    final jsonDataLogin = jsonDecode(data!);
    final dataLogin = PostLogin.fromJson(jsonDataLogin);
    return dataLogin;
  }

  Future<void> setStatusLogin() async {
    await setBoolPrefs(loginStatus, true);
  }

  Future<bool> getStatusLogin() async {
    final isStatus = await getBoolPrefs(loginStatus);
    return isStatus ?? false;
  }

  Future<String?> getToken() async {
    try {
      final login = await getDataLogin();
      return login.token;
    } catch (e) {
      return null;
    }
  }
}
