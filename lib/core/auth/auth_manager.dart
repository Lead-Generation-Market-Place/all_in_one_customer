// core/auth/auth_manager.dart
import 'package:flutter/material.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import 'package:yelpax/features/signin/domain/entities/signin_entity.dart';
import 'package:yelpax/features/signin/domain/repositories/auth_repository.dart';

class AuthManager with ChangeNotifier {
  final AuthRepository _authRepository;
  
  // Auth state
  bool _isLoading = false;
  bool _isLoggedIn = false;
  SigninEntity? _currentUser;
  String? _error;

  AuthManager(this._authRepository) {
    _initialize();
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  SigninEntity? get currentUser => _currentUser;
  String? get error => _error;

  // Initialize auth state
  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isLoggedIn = await _authRepository.isLoggedIn();
      if (_isLoggedIn) {
        final result = await _authRepository.getCurrentUser();
        result.fold((error) {
          _error=error.message;
        }, (user) {
          _currentUser=user;
        },);
      
      }
    } catch (e) {
      _error = 'Failed to initialize auth state: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login method
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authRepository.signIn(email, password);
      
      return result.fold(
        (failure) {
          _error = failure.message;
          return false;
        },
        (signInEntity) {
          _isLoggedIn = true;
          _currentUser = signInEntity;
          _error = null;
          return true;
        },
      );
    } catch (e) {
      _error = 'Login failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout method
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signOut();
      _isLoggedIn = false;
      _currentUser = null;
      _error = null;
      
      // Navigate to login screen
      _navigateToLogin();
    } catch (e) {
      _error = 'Logout failed: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Check if user is authenticated
  Future<bool> checkAuthStatus() async {
    try {
      _isLoggedIn = await _authRepository.isLoggedIn();
      if (_isLoggedIn) {
        final result = await _authRepository.getCurrentUser();
          result.fold((error) {
          _error=error.message;
        }, (user) {
          _currentUser=user;
        },);
      
      }
      notifyListeners();
      return _isLoggedIn;
    } catch (e) {
      _error = 'Auth check failed: $e';
      notifyListeners();
      return false;
    }
  }

  // Clear errors
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Refresh user data
  Future<void> refreshUserData() async {
    if (_isLoggedIn) {
      try {
        final result = await _authRepository.getCurrentUser();
        result.fold((error) {
          _error=error.message;
        }, (user) {
          _currentUser=user;
        },);
      
        notifyListeners();
      } catch (e) {
        _error = 'Failed to refresh user data: $e';
      }
    }
  }

  // Navigation helper
  void _navigateToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AppConstants.navigateKeyword.currentState != null) {
        AppConstants.navigateKeyword.currentState?.pushNamedAndRemoveUntil(
          AppRouter.signIn, 
          (route) => false,
        );
      }
    });
  }

Future<void> handleTokenExpired() async {
  await _authRepository.signOut();
  _isLoggedIn = false;
  _currentUser = null;
  _error = 'Session expired. Please login again.';
  notifyListeners();
  _navigateToLogin();
}
  // Force logout (e.g., when token is invalid)
  // Future<void> forceLogout() async {
  //   await _authRepository.
  //   _isLoggedIn = false;
  //   _currentUser = null;
  //   _error = 'Session expired. Please login again.';
  //   notifyListeners();
  //   _navigateToLogin();
  // }
}