// core/network/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:yelpax/core/auth/auth_manager.dart';
import 'package:yelpax/core/constants/app_constants.dart';

import '../../features/signin/domain/repositories/auth_repository.dart';
import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthManager authManager;
  // final LocalStorageService localStorageService;
  // final AuthRepository authRepository;

  AuthInterceptor({
    required this.authManager
  });

@override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Token will be added automatically via secure storage in repository
    // You can add additional headers here if needed
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired - force logout
      await authManager.logout();//forcing logout when token expired
    }
    handler.next(err);
  }

  
}