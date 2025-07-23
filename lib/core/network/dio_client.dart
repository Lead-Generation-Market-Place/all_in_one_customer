import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  final Dio dio = Dio();

  factory DioClient() => _instance;

  DioClient._internal() {
    dio.options.baseUrl = "https://your.api.url";
    dio.options.headers = {'Content-Type': 'application/json'};
  }
}
