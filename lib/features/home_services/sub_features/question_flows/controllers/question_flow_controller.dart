import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals_id_zipcode/controllers/home_services_findpros_controller.dart';

class QuestionFlowController extends ChangeNotifier {
  final List<HomeServicesQuestionEntity> _questions;
  final PageController pageController = PageController();
  
  // State
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isQuestionFlowCompleted = false;
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

  QuestionFlowController({required List<HomeServicesQuestionEntity> questions})
      : _questions = questions {
    _initializeUserAnswers();
  }

  // ========== PUBLIC METHODS ==========

  /// Submit answer for current question and move to next
  void submitAnswerAndContinue(dynamic answer) {
    submitAnswer(_currentPageIndex, answer);
    
    if (!isLastQuestion && isCurrentQuestionValid()) {
      nextPage();
    } else if (isLastQuestion) {
      _completeFlow();
    }
  }

  /// Navigate to previous question
  void goToPreviousQuestion() {
    if (!isFirstQuestion) {
      previousPage();
    }
  }

  /// Get answer for specific question
  dynamic getAnswerForQuestion(int questionIndex) {
    return _userAnswers[questionIndex];
  }

  /// Check if specific question is answered
  bool isQuestionAnswered(int questionIndex) {
    final answer = _userAnswers[questionIndex];
    return _isValidAnswer(answer);
  }

  /// Submit the completed flow
  void submitFlow(String option, BuildContext context) {
    _logFlowSubmission(option);
    
    final findProsController = _getFindProsController(context);
    _logControllerState(findProsController);
    
    final sendOption = _getSendOption(option);
    _createLead(findProsController, sendOption, context);
    
    _isQuestionFlowCompleted = false;
    SmartDialog.showToast('Quotation sent to $option!');
  }

  /// Complete flow and return formatted answers
  Map<String, dynamic> completeFlow() {
    final formattedAnswers = _getFormattedAnswers();
    _logFlowCompletion(formattedAnswers.length);
    return formattedAnswers;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // ========== PRIVATE METHODS ==========

  void _initializeUserAnswers() {
    for (int i = 0; i < _questions.length; i++) {
      _userAnswers[i] = null;
    }
  }

  void submitAnswer(int questionIndex, dynamic answer) {
    _userAnswers[questionIndex] = answer;
    notifyListeners();
  }

  bool isCurrentQuestionValid() {
    final currentQuestion = _questions[_currentPageIndex];
    if (!currentQuestion.requiredField) return true;
    return isQuestionAnswered(_currentPageIndex);
  }

    void nextPage() {
    if (!isLastQuestion && isCurrentQuestionValid()) {
      _currentPageIndex++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else if (isLastQuestion && isCurrentQuestionValid()) {
      _completeFlow();
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

  void _completeFlow() {
    if (kDebugMode) {
      SmartDialog.showToast(
        'Submitted answers: $_userAnswers',
        animationTime: const Duration(seconds: 5),
      );
    }
    _isQuestionFlowCompleted = true;
    _isLoading = true;
    notifyListeners();
  }

  Map<String, dynamic> _getFormattedAnswers() {
    final Map<String, dynamic> formattedAnswers = {};

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final answer = _userAnswers[i];

      if (_isValidAnswer(answer)) {
        formattedAnswers[question.id] = answer is List 
            ? answer.join(', ') 
            : answer.toString();
      }
    }

    return formattedAnswers;
  }

  bool _isValidAnswer(dynamic answer) {
    if (answer == null) return false;
    if (answer is String) return answer.trim().isNotEmpty;
    if (answer is List) return answer.isNotEmpty;
    return true;
  }

  HomeServicesFindprosController _getFindProsController(BuildContext context) {
    return Provider.of<HomeServicesFindprosController>(context, listen: false);
  }

  String _getSendOption(String option) {
    return option == 'fiveProfessionals' ? 'top5' : 'selected';
  }

  Future<void> _createLead(
    HomeServicesFindprosController findProsController,
    String sendOption,
    BuildContext context,
  ) async {
    _logLeadCreationStart(findProsController, sendOption);

    try {
      await findProsController.createQuickLead(
        userEmail: "assisstant45@gmail.com",
        userPhone: '+1234567890',
        description: 'Service request completed via question flow',
        sendOption: sendOption
      );

      _logLeadCreationSuccess();
      _navigateToHome(context);
    } catch (e) {
      _logLeadCreationError(e);
      SmartDialog.showToast('Failed to create lead: $e');
    }
  }

  void _navigateToHome(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppConstants.navigateKeyword.currentState!.pushNamedAndRemoveUntil(
        AppRouter.homeServices,
        (route) => false,
      );
    });
  }

  // Logging
  void _logFlowSubmission(String option) {
    print('🎯 Submitting flow with option: $option');
  }

  void _logControllerState(HomeServicesFindprosController controller) {
    print('🔍 CONTROLLER STATE BEFORE LEAD CREATION:');
    print('🔍 selectedServiceId: ${controller.selectedServiceId}');
    print('🔍 selectedProfessionalId: ${controller.selectedProfessionalId}');
    print('🔍 questionAnswers: ${controller.questionAnswers}');
  }

  void _logFlowCompletion(int answerCount) {
    print('📝 Flow completed with $answerCount answers');
  }

  void _logLeadCreationStart(
    HomeServicesFindprosController controller, 
    String sendOption
  ) {
    print('🚀 Starting lead creation...');
    print('🔍 Question Answers: ${controller.questionAnswers}');
    print('🎯 Selected Professional: ${controller.selectedProfessionalId}');
    print('🛠️ Service ID: ${controller.selectedServiceId}');
    print('📤 Send Option: $sendOption');
  }

  void _logLeadCreationSuccess() {
    print('✅ Lead creation process completed');
  }

  void _logLeadCreationError(Object error) {
    print('❌ Lead creation failed: $error');
  }
}