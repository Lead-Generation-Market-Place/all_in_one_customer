import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> isOnboardingCompleted();
  Future<bool> setOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  @override
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.onboarding_completed) ?? false;
  }

  @override
  Future<bool> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(AppConstants.onboarding_completed, true);
  }
}
