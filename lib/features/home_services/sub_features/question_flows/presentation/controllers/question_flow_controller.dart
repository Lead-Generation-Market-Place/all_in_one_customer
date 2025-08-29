import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/usecases/question_flow_usecase.dart';

class QuestionFlowController extends ChangeNotifier {
  QuestionFlowUsecase _usecase;
  QuestionFlowController(this._usecase) {
    initializedQuestions();
  }

  bool _isLoadingQuestion = false;
  bool _isLoading = false;
  List<QuestionFlowEntity> _questions = [];
  String _errorMessage = '';

  bool get isLoadingQuestion => _isLoadingQuestion;
  bool get isLoading => _isLoading;
  List<QuestionFlowEntity> get questions => _questions;
  String get errorMessage => _errorMessage;

  Future initializedQuestions() async {
    _isLoadingQuestion = true;
    notifyListeners();
    final result = await _usecase('q1');

    result.fold(
      (left) {
        print('Error occured ${left.message}');
        _errorMessage = left.message;
        _isLoadingQuestion = false;
        notifyListeners();
      },
      (right) {
        print('data loaded successfull ${right}');
        _questions = right;
        _isLoadingQuestion = false;
        notifyListeners();
      },
    );
  }
}
