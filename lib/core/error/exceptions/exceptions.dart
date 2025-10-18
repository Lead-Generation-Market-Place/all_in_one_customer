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
class NotFoundException implements Exception{
  final String message;
  NotFoundException(this.message);
}
class CustomDioException implements Exception{
  final String message;
  CustomDioException(this.message);
}
class PermissionException implements Exception{
  final String message;
  PermissionException(this.message);
}
class LocationException implements Exception{
  final String message;
  LocationException(this.message);
}
class TimeoutException implements Exception{
  final String message;
  TimeoutException(this.message);
}
