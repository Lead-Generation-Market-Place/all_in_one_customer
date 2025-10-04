// core/storage/secure_storage_service.dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yelpax/features/signin/data/models/signin_model.dart';

abstract class LocalStorageService {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUser(SigninModel userModel);
  Future<SigninModel?> getUser();
  Future<void> clearAll();
}

class SecureStorageService implements LocalStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  @override
  Future<void> saveUser(SigninModel userModel) async {
    final userJson = jsonEncode(userModel.toJson());
    await _secureStorage.write(key: 'user', value: userJson);
  }

  @override
  Future<SigninModel?> getUser() async {
    final userString = await _secureStorage.read(key: 'user');
    if (userString != null) {
      try {
        final userMap = jsonDecode(userString) as Map<String, dynamic>;
        return SigninModel.fromJson(userMap);
      } catch (e) {
        await _secureStorage.delete(key: 'user'); // Clear corrupted data
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  // Additional secure methods
  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  Future<void> saveUserId(String userId) async {
    await _secureStorage.write(key: 'user_id', value: userId);
  }

  Future<String?> getUserId() async {
    return await _secureStorage.read(key: 'user_id');
  }
}