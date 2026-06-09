import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetConnection {
  static Future<bool> check() async {
    final result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.mobile)) {
      return true;
    }

    if (result.contains(ConnectivityResult.wifi)) {
      return true;
    }

    if (result.contains(ConnectivityResult.ethernet)) {
      return true;
    }

    return false;
  }
}
