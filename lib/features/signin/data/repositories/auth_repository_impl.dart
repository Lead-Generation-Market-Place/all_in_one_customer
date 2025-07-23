import 'package:yelpax/features/signin/data/models/signin_model.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<SigninModel> signIn(String email, String password) {
    return remoteDataSource.signIn(email, password);
  }
}
