// question_flow_controller.dart
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
  final Function(Map<String, dynamic>)? onFlowCompleted;
  QuestionFlowController({
    required List<HomeServicesQuestionEntity> questions,
    this.onFlowCompleted,
  }) : _questions = questions {
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
    if (!currentQuestion.requiredField)
      return true; // Non-required questions are always valid
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

    final formattedAnswers = _getFormattedAnswers();
    onFlowCompleted?.call(formattedAnswers);
  }

  /// Get answers in the format needed for lead creation
  Map<String, dynamic> _getFormattedAnswers() {
    final Map<String, dynamic> formattedAnswers = {};

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final answer = _userAnswers[i];

      if (answer != null && _isValidAnswer(answer)) {
        formattedAnswers[question.id] = answer is List
            ? answer.join(', ')
            : answer.toString();
      }
    }

    return formattedAnswers;
  }

  /// Submit the flow with the selected option
  void submitFlow(String option, BuildContext context) {
     print('🎯 Submitting flow with option: $option');
    
    final findProsController = Provider.of<HomeServicesFindprosController>(
      context,
      listen: false,
    );
        // Debug the controller state
    print('🔍 CONTROLLER STATE BEFORE LEAD CREATION:');
    print('🔍 selectedServiceId: ${findProsController.selectedServiceId}');
    print('🔍 selectedProfessionalId: ${findProsController.selectedProfessionalId}');
    print('🔍 questionAnswers: ${findProsController.questionAnswers}');
    
    // Determine send option based on user selection
    String sendOption;
    if (option == 'fiveProfessionals') {
      sendOption = 'top5';
      print('📤 Sending to top 5 professionals');
    } else {
      sendOption = 'selected';
      print('📤 Sending to selected professional');
    }
    // Create the lead
    _createLead(findProsController, sendOption, context);
    _isQuestionFlowCompleted = false;
    SmartDialog.showToast('Quotation sent to $option!');
    // // A flow where submit to send 5 or one professional and get back
    // AppConstants.navigateKeyword.currentState!.pushNamed(
    //   AppRouter.homeServices,
    // );
    // _isQuestionFlowCompleted = false;
    // SmartDialog.showToast('Quotation Will Send To $option');
  }

  /// Create lead with the collected data
  void _createLead(
    HomeServicesFindprosController findProsController,
    String sendOption,
    BuildContext context,
  ) async {
    print('🚀 Starting lead creation...');
    print('🔍 Question Answers: ${findProsController.questionAnswers}');
    print(
      '🎯 Selected Professional: ${findProsController.selectedProfessionalId}',
    );
    print('🛠️ Service ID: ${findProsController.selectedServiceId}');
    print('📤 Send Option: $sendOption');

    try {
      // You need to get actual user data here - this is just an example
      // await findProsController.createQuickLead(
      //   userEmail: 'user@example.com', // TODO: Get from user profile/input
      //   userPhone: '+1234567890',      // TODO: Get from user profile/input
      //   description: 'Service request completed via question flow',
      // );
      
      await findProsController.createQuickLead(
      userEmail: "assisstant45@gmail.com",
       userPhone: '+1234567890',      // Test data
        description: 'Service request completed via question flow',
      );
      
      print('✅ Lead creation process completed');

      // Navigate after successful lead creation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppConstants.navigateKeyword.currentState!.pushNamedAndRemoveUntil(
          AppRouter.homeServices,
          (route) => false,
        );
      });
    } catch (e) {
      print('❌ Lead creation failed: $e');
      SmartDialog.showToast('Failed to create lead: $e');
    }
  }

  /// Complete the flow and return answers in the correct format
  Map<String, dynamic> completeFlow() {
    final Map<String, dynamic> formattedAnswers = {};

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final answer = _userAnswers[i];

      if (answer != null && _isValidAnswer(answer)) {
        formattedAnswers[question.id] = answer is List
            ? answer.join(', ')
            : answer.toString();
      }
    }

    // DON'T set _isQuestionFlowCompleted here to avoid infinite loops
    print('📝 Flow completed with ${formattedAnswers.length} answers');

    return formattedAnswers;
  }

  bool _isValidAnswer(dynamic answer) {
    if (answer == null) return false;
    if (answer is String) return answer.trim().isNotEmpty;
    if (answer is List) return answer.isNotEmpty;
    return true;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
