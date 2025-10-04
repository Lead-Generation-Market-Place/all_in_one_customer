import 'data/datasources/onboarding_local_data_source.dart';
import 'data/repositories_impl/onboarding_repository_impl.dart';
import 'domain/usecases/get_onboarding_completed_usecase.dart';
import 'domain/usecases/set_onboarding_completed_usecase.dart';
import 'presentation/controllers/onboarding_controller.dart';

OnboardingController createOnboardingController() {
  final source = OnboardingLocalDataSourceImpl();
  final repo = OnboardingRepositoryImpl(source);
  final getusecase = GetOnboardingCompletedUsecase(repo);
  final setusecase = SetOnboardingCompletedUsecase(repo);
  return OnboardingController(getusecase, setusecase);
}
