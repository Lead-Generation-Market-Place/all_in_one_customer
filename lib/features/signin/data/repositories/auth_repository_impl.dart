import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/core/error/handler/error_handler.dart';
import 'package:yelpax/core/network/network_info.dart';
import 'package:yelpax/core/storage/secure_storage_service.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/signin_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalStorageService localStorageService;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorageService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SigninModel>> signIn(
    String email,
    String password,
  ) async {
    if (!await networkInfo.isConnected) {
    
      return Left(NoInternetFailure('No Internet Connection!'));
      
    }
    try {
      final signInModel = await remoteDataSource.signIn(email, password);
      await localStorageService.saveToken(signInModel.token);
      await localStorageService.saveUser(signInModel);
      await localStorageService.saveUserId(signInModel.user.id);
      return Right(signInModel);
    } catch (e) {
      if (e is Exception) {
        print('Error on network');
        final failure = ErrorHandler.mapExceptionToFailure(e);
        return Left(failure);
      } else {
     
        return Left(GenericFailure('An unknown error occurred.'));
      }
    }
  }

  @override
  Future<void> signOut() async {
    await localStorageService.clearAll();
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await localStorageService.getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, SigninModel>> getCurrentUser() async {
    try {
      final user = await localStorageService.getUser();
      if (user == null) {
        return Left(CacheFailure("No user found in cache"));
      }
      return Right(user);
    } catch (e) {
      if (e is Exception) {
        final failure = ErrorHandler.mapExceptionToFailure(e);
        return Left(failure);
      }
      return Left(CacheFailure("Error On Getting User From Cache"));
    }
  }
}
