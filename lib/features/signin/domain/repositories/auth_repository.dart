import 'package:yelpax/features/signin/domain/entities/signin_entity.dart';

abstract class AuthRepository {
  Future<SigninEntity> signIn(String email, String password);
}
