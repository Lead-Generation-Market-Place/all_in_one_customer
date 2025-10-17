import 'dart:io';
import 'package:flutter/foundation.dart';
import '../exceptions/exceptions.dart';
import '../failures/failure.dart';

class ErrorHandler {
  static Failure mapExceptionToFailure(Exception e) {
    debugPrint('Exception caught $e');
    if (e is ServerException) return ServerFailure(e.message);
    if (e is NetworkException) return NetworkFailure(e.message);
    if (e is ValidationException) return ValidationFailure(e.message);
    if (e is CacheException) return CacheFailure(e.message);
    if (e is SocketException) return NoInternetFailure(e.message);
    if (e is NotFoundException) return NotFoundFailure(e.message);
    if (e is CustomDioException) return DioFailure(e.message);

    return GenericFailure('Unexpected error occurred');
  }
}
