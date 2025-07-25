import 'package:yelpax/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:yelpax/features/onboarding/data/repositories_impl/onboarding_repository_impl.dart';
import 'package:yelpax/features/onboarding/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:yelpax/features/onboarding/domain/usecases/set_onboarding_completed_usecase.dart';
import 'package:yelpax/features/onboarding/presentation/controllers/onboarding_controller.dart';

OnboardingController createOnboardingController() {
  final source = OnboardingLocalDataSourceImpl();
  final repo = OnboardingRepositoryImpl(source);
  final getusecase = GetOnboardingCompletedUsecase(repo);
  final setusecase = SetOnboardingCompletedUsecase(repo);
  return OnboardingController(getusecase, setusecase);
}
