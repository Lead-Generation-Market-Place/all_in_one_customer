// core/network/auth_interceptor.dart - Enhanced version
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/routes/router.dart';
import '../constants/app_constants.dart';
import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorageService localStorageService;
  final ValueNotifier<String?> currentRouteNotifier = ValueNotifier(null);

  AuthInterceptor({required this.localStorageService});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Store request context for error handling
    options.extra['request_timestamp'] = DateTime.now();
    options.extra['is_auth_request'] = _isAuthRequest(options.path);

    try {
      final token = await localStorageService.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // If we can't get the token, proceed without it
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final isAuthRequest = err.requestOptions.extra['is_auth_request'] == true;
      final isLoginScreen = _isCurrentlyOnLoginScreen();

      if (!isAuthRequest && !isLoginScreen) {
        // Only handle 401 for non-auth requests when not on login screen
        await _handleTokenExpired();
      }
      // For auth requests or when on login screen, let the error propagate
    }
    handler.next(err);
  }

  bool _isAuthRequest(String path) {
    return path.contains('auth/login') ||
           path.contains('auth/signin') ||
           path.contains('auth/register') ||
           path.contains('auth/refresh');
  }

  bool _isCurrentlyOnLoginScreen() {
    final navigator = AppConstants.navigateKeyword.currentState;
    if (navigator == null) return false;

    String? currentRoute;
    navigator.popUntil((route) {
      currentRoute = route.settings.name;
      return true;
    });
    
    return currentRoute == AppRouter.signIn;
  }

  Future<void> _handleTokenExpired() async {
    await localStorageService.clearAll();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigator = AppConstants.navigateKeyword.currentState;
      if (navigator != null && !_isCurrentlyOnLoginScreen()) {
        navigator.pushNamedAndRemoveUntil(
          AppRouter.signIn,
          (route) => false,
        );
      }
    });
  }
}