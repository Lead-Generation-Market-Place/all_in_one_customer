import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';

class QuestionFlowModel extends QuestionFlowEntity {
  QuestionFlowModel({required super.questions, required super.currentStep});

  factory QuestionFlowModel.fromJson(Map<String, dynamic> json) {
    return QuestionFlowModel(
      questions: json['questions'] ?? [],
      currentStep: json['currentStep'] ?? 0,
    );
  }
}
