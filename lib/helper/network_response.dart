import 'package:sinden_tb_app/constan/const.dart';

class NetworkResponse {
  final Status status;
  final Map<String, dynamic>? data;
  final String? message;

  NetworkResponse(
    this.status,
    this.data,
    this.message,
  );

  static NetworkResponse success({data}) {
    return NetworkResponse(Status.success, data, null);
  }

  static NetworkResponse error({data, String? message}) {
    return NetworkResponse(Status.error, data, message);
  }

  static NetworkResponse connection({data, String? message}) {
    return NetworkResponse(Status.connection, data, message);
  }

  static NetworkResponse loading({data}) {
    return NetworkResponse(Status.loading, data, null);
  }

  static NetworkResponse timeout() {
    return NetworkResponse(Status.timeOut, null, null);
  }

  static NetworkResponse internetError() {
    return NetworkResponse(Status.internetError, null, null);
  }
}
