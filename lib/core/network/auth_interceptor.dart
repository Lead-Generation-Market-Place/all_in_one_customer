// core/network/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:yelpax/core/constants/app_constants.dart';

import '../../features/signin/domain/repositories/auth_repository.dart';
import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorageService localStorageService;
  final AuthRepository authRepository;

  AuthInterceptor({
    required this.localStorageService,
    required this.authRepository,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await localStorageService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired - attempt refresh or logout
      await _handleTokenExpired();
    }
    handler.next(err);
  }

  Future<void> _handleTokenExpired() async {
    // Implement token refresh logic here if your API supports it
    // Otherwise, just logout
    await localStorageService.clearAll();
    
    // You can use a global key to navigate to login
    AppConstants.navigateKeyword.currentState?.pushReplacementNamed('/login');
  }
}