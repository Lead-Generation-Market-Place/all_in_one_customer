import '../entities/signin_entity.dart';

import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<SigninEntity> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
