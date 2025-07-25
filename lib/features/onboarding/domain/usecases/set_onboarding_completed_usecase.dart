import 'package:yelpax/features/onboarding/domain/repositories/onboarding_repository.dart';

class SetOnboardingCompletedUsecase {
  final OnboardingRepository _repository;
  SetOnboardingCompletedUsecase(this._repository);

  Future<bool> call() async {
    return _repository.setOnboardingCompleted();
  }
}
