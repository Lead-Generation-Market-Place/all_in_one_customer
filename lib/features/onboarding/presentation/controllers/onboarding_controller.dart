import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:yelpax/features/onboarding/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:yelpax/features/onboarding/domain/usecases/set_onboarding_completed_usecase.dart';

class OnboardingController extends ChangeNotifier {
  final GetOnboardingCompletedUsecase _isOnboardingCompleted;
  final SetOnboardingCompletedUsecase _setOnboardingCompletedUsecase;

  OnboardingController(
    this._isOnboardingCompleted,
    this._setOnboardingCompletedUsecase,
  );

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;

  final PageController pageController = PageController();
  Future<bool> ensureOnboardingCompleted() async {
    _isCompleted = await _isOnboardingCompleted.call();
    notifyListeners();
    return _isCompleted;
  }

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  Future markCompleted() async {
    await _setOnboardingCompletedUsecase.call();
    _isCompleted = true;
    notifyListeners();
  }

  void onNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void disposeController() {
    pageController.dispose();
    super.dispose();
  }
}
