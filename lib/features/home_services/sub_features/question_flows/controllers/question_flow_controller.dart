// question_flow_controller.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/core/constants/app_constants.dart';

import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';


class QuestionFlowController extends ChangeNotifier {
  final List<HomeServicesQuestionEntity> _questions;
  QuestionFlowController({required List<HomeServicesQuestionEntity> questions})
      : _questions = questions {
    _userAnswers.addAll(
      Map.fromIterable(
        List.generate(_questions.length, (index) => index),
        value: (index) => null,
      ),
    );
  }

  // Data Loading State
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isQuestionFlowCompleted = false;

  // Flow State
  final PageController pageController = PageController();
  int _currentPageIndex = 0;
  final Map<int, dynamic> _userAnswers =
      {}; // Key: question index, Value: answer

  // Getters
  // bool get isLoadingQuestion => _isLoadingQuestion; // No longer needed
  bool get isLoading => _isLoading;
  List<HomeServicesQuestionEntity> get questions => _questions;
  String get errorMessage => _errorMessage;
  bool get isQuestionFlowCompleted => _isQuestionFlowCompleted;

  int get currentPageIndex => _currentPageIndex;
  int get totalQuestions => _questions.length;
  bool get isFirstQuestion => _currentPageIndex == 0;
  bool get isLastQuestion => _currentPageIndex == totalQuestions - 1;

  // Removed initializeQuestions, as questions are now passed in constructor

  dynamic getAnswerForQuestion(int questionIndex) {
    return _userAnswers[questionIndex];
  }

  void submitAnswer(int questionIndex, dynamic answer) {
    _userAnswers[questionIndex] = answer;
    notifyListeners(); // Rebuild UI if needed (e.g., to show selection)
  }

  void nextPage() {
    if (!isLastQuestion) {
      _currentPageIndex++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else {
      // All questions are answered! Handle completion.
      _finishFlow();
    }
  }

  void previousPage() {
    if (!isFirstQuestion) {
      _currentPageIndex--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  // Add a helper method to get selected option IDs for multiple choice
  List<String> getSelectedOptionIdsForQuestion(int questionIndex) {
    final answer = _userAnswers[questionIndex];
    if (answer is List<String>) {
      return answer;
    }
    return [];
  }

  void _finishFlow() {
    if (kDebugMode) {
      SmartDialog.showToast(
        'Submitted answers are: $_userAnswers',
        animationTime: Duration(seconds: 5),
      );
    }
    _isQuestionFlowCompleted = true;
    _isLoading = true;
    notifyListeners();
    // TODO: Here you would call another usecase to submit the final answers.
    // For example: _usecase.submitAnswers(_userAnswers);
    // Then handle the result, set _isLoading to false, etc.
  }

  void submitFlow(String option) {//a flow where submit to send 5 or one professional and get back
    AppConstants.navigateKeyword.currentState!.pushNamed(AppRouter.homeServices);
    _isQuestionFlowCompleted = false;
    SmartDialog.showToast('Quotation Will Send To $option');
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
