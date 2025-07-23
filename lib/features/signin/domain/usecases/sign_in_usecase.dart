import 'package:yelpax/features/signin/domain/entities/signin_entity.dart';

import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<SigninEntity> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
