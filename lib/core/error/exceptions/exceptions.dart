class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}
