import 'package:yelpax/features/home_services/domain/entities/home_services_answer_entity.dart';

class HomeServicesAnswersModel extends HomeServicesAnswerEntity {
  HomeServicesAnswersModel({
    required super.questionId,
    required super.answer,
    super.isFallback = false,
  });

  factory HomeServicesAnswersModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesAnswersModel(
      questionId: json['question_id'] ?? '',
      answer: json['answer'] ?? '',
      isFallback: json['is_fallback'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer': answer,
      'is_fallback': isFallback,
    };
  }
}