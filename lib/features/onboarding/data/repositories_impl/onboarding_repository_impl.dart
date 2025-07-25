import 'package:shared_preferences/shared_preferences.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import 'package:yelpax/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
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
