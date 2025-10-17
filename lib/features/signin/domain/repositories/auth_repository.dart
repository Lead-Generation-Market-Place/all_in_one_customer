import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/signin/data/models/signin_model.dart';

import '../entities/signin_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,SigninEntity>> signIn(String email, String password);
  Future<void> signOut();
  Future<bool>isLoggedIn();
  Future<Either<Failure,SigninModel>>getCurrentUser();
}
