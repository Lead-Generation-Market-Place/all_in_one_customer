import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';

import '../entities/signin_entity.dart';

import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<Either<Failure,SigninEntity>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
