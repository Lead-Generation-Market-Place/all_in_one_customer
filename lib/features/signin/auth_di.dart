import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'presentation/controllers/sign_in_controller.dart';

SignInController createSignInController() {
  final remote = AuthRemoteDataSource();
  final repo = AuthRepositoryImpl(remote);
  final useCase = SignInUseCase(repo);
  return SignInController(useCase);
}
