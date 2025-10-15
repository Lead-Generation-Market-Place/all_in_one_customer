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
    _initializeUserAnswers();
  }

  // Data Loading State
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isQuestionFlowCompleted = false;

  // Flow State
  final PageController pageController = PageController();
  int _currentPageIndex = 0;
  final Map<int, dynamic> _userAnswers = {};

  // Getters
  bool get isLoading => _isLoading;
  List<HomeServicesQuestionEntity> get questions => _questions;
  String get errorMessage => _errorMessage;
  bool get isQuestionFlowCompleted => _isQuestionFlowCompleted;
  int get currentPageIndex => _currentPageIndex;
  int get totalQuestions => _questions.length;
  bool get isFirstQuestion => _currentPageIndex == 0;
  bool get isLastQuestion => _currentPageIndex == totalQuestions - 1;

  /// Initialize user answers map with null values for each question
  void _initializeUserAnswers() {
    for (int i = 0; i < _questions.length; i++) {
      _userAnswers[i] = null;
    }
  }

  /// Get the answer for a specific question
  dynamic getAnswerForQuestion(int questionIndex) {
    return _userAnswers[questionIndex];
  }

  /// Check if a specific question has been answered
  bool isQuestionAnswered(int questionIndex) {
    final answer = _userAnswers[questionIndex];
    if (answer == null) return false;
    if (answer is String) return answer.trim().isNotEmpty;
    if (answer is List) return answer.isNotEmpty;
    return true; // For other types, consider them as answered if not null
  }

  /// Check if the current question is valid (answered if required)
  bool isCurrentQuestionValid() {
    final currentQuestion = _questions[_currentPageIndex];
    if (!currentQuestion.requiredField) return true; // Non-required questions are always valid
    return isQuestionAnswered(_currentPageIndex);
  }

  /// Submit an answer for a specific question
  void submitAnswer(int questionIndex, dynamic answer) {
    _userAnswers[questionIndex] = answer;
    notifyListeners(); // Rebuild UI if needed (e.g., to show selection)
  }

  /// Navigate to the next question page if valid
  void nextPage() {
    if (!isLastQuestion && isCurrentQuestionValid()) {
      _currentPageIndex++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else if (isLastQuestion) {
      // All questions are answered! Handle completion.
      _finishFlow();
    }
  }

  /// Navigate to the previous question page
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

  /// Get selected option IDs for multiple choice questions
  List<String> getSelectedOptionIdsForQuestion(int questionIndex) {
    final answer = _userAnswers[questionIndex];
    if (answer is List<String>) {
      return answer;
    }
    return [];
  }

  /// Complete the question flow
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

  /// Submit the flow with the selected option
  void submitFlow(String option) {
    // A flow where submit to send 5 or one professional and get back
    AppConstants.navigateKeyword.currentState!.pushNamed(
      AppRouter.homeServices,
    );
    _isQuestionFlowCompleted = false;
    SmartDialog.showToast('Quotation Will Send To $option');
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
