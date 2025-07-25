import 'package:yelpax/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetOnboardingCompletedUsecase {
  final OnboardingRepository _repository;
  GetOnboardingCompletedUsecase(this._repository);
  Future<bool> call() async {
    return await _repository.isOnboardingCompleted();
  }
}
