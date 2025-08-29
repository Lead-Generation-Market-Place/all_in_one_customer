// question_flow_controller.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/usecases/question_flow_usecase.dart';
import 'package:yelpax/main.dart';

class QuestionFlowController extends ChangeNotifier {
  final QuestionFlowUsecase _usecase;
  QuestionFlowController(this._usecase) {
    initializeQuestions();
  }

  // Data Loading State
  bool _isLoadingQuestion = false;
  bool _isLoading = false;
  List<QuestionFlowEntity> _questions = [];
  String _errorMessage = '';

  // Flow State
  final PageController pageController = PageController();
  int _currentPageIndex = 0;
  final Map<int, dynamic> _userAnswers =
      {}; // Key: question index, Value: answer

  // Getters
  bool get isLoadingQuestion => _isLoadingQuestion;
  bool get isLoading => _isLoading;
  List<QuestionFlowEntity> get questions => _questions;
  String get errorMessage => _errorMessage;

  int get currentPageIndex => _currentPageIndex;
  int get totalQuestions =>
      _questions.isNotEmpty ? _questions[0].questions.length : 0;
  bool get isFirstQuestion => _currentPageIndex == 0;
  bool get isLastQuestion => _currentPageIndex == totalQuestions - 1;

  Future<void> initializeQuestions() async {
    _isLoadingQuestion = true;
    notifyListeners();

    final result = await _usecase('q1'); // Or pass a dynamic ID

    result.fold(
      (failure) {
        print('Error occurred ${failure.message}');
        _errorMessage = failure.message;
        _isLoadingQuestion = false;
        notifyListeners();
      },
      (questionFlows) {
        print('Data loaded successfully ${questionFlows}');
        _questions = questionFlows;
        _isLoadingQuestion = false;
        // Initialize the answers map once we have the questions
        _userAnswers.addAll(
          Map.fromIterable(
            List.generate(totalQuestions, (index) => index),
            value: (index) => null, // Initialize all answers to null
          ),
        );
        notifyListeners();
      },
    );
  }

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
    if (answer is List<Option>) {
      return answer.map((option) => option.id).toList();
    }
    return [];
  }

  void _finishFlow() {
    if (kDebugMode) {
      print("Flow completed! Answers: $_userAnswers");
    navigatorKey.currentState!.pop();
    }
    _isLoading = true;
    notifyListeners();
    // TODO: Here you would call another usecase to submit the final answers.
    // For example: _usecase.submitAnswers(_userAnswers);
    // Then handle the result, set _isLoading to false, etc.
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
