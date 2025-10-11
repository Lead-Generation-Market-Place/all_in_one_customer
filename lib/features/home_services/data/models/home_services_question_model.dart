import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';

class HomeServicesQuestionModel extends HomeServicesQuestionEntity {
  HomeServicesQuestionModel({
    required super.id,
    required super.serviceId,
    required super.questionName,
    required super.formType,
    required super.options,
    required super.requiredField,
    required super.order,
    required super.active,
    required super.createdAt,
    required super.updatedAt,
  });

  factory HomeServicesQuestionModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesQuestionModel(
      id: json['_id']??"",
      serviceId: json["serviceId"]??"",
      questionName: json["questionName"]??"",
      formType: json["formType"]??"",
      options: List<String>.from(json['options'] ?? []),
      requiredField: json["requiredField"] ?? false,
      order: json["order"] ?? 0,
      active: json["active"] ?? false,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
  factory HomeServicesQuestionModel.empty() {
    return HomeServicesQuestionModel(
      id: '',
      serviceId: '',
      questionName: '',
      formType: '',
      options: [],
      requiredField: false,
      order: 0,
      active: false,
      createdAt: '',
      updatedAt: '',
    );
  }
}
