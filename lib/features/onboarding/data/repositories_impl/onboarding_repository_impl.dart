import 'package:yelpax/features/onboarding/data/datasources/onboarding_local_data_source.dart';

import '../../domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _onboardingLocalDataSource;
  OnboardingRepositoryImpl(this._onboardingLocalDataSource);

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _onboardingLocalDataSource.isOnboardingCompleted();
  }

  @override
  Future<bool> setOnboardingCompleted() async {
    return await _onboardingLocalDataSource.setOnboardingCompleted();
  }
}
