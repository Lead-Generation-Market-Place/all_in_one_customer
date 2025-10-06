// core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:yelpax/core/auth/auth_manager.dart';
import 'package:yelpax/core/network/auth_interceptor.dart';
import 'package:yelpax/core/injection_container.dart' as di;
import 'package:yelpax/core/storage/secure_storage_service.dart';
class DioClient {
  final Dio dio;
  final Logger logger;

  DioClient({required this.dio, required this.logger}) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(AuthInterceptor(localStorageService: di.getIt<LocalStorageService>()));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
    //    logger.i('🌍 REQUEST: ${options.method} ${options.uri}');
   //     logger.i('Headers: ${options.headers}');
        if (options.data != null) {
   //       logger.i('Body: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
   //     logger.i('✅ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
   //     logger.i('Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, handler) {
    //    logger.e('❌ ERROR: ${error.type} ${error.response?.statusCode}');
 //       logger.e('Message: ${error.message}');
        return handler.next(error);
      },
    ));

    // Add logging interceptor for detailed logs
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
   //   logPrint: (object) => logger.d(object),
    ));
  }

  // Generic GET method
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Generic POST method
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Generic PUT method
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Generic DELETE method
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}