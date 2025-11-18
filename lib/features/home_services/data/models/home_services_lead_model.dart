import 'package:yelpax/features/home_services/data/models/home_services_answers_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_lead_file_model.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_lead_entity.dart';

class HomeServicesLeadModel extends HomeServicesLeadEntity {
  HomeServicesLeadModel({
    required super.id,
    required super.serviceId,
    required super.userId,
    required super.title,
    required super.note,
    required super.answers,
    required super.files,
    required super.sendOption,
    required super.createdAt,
  });

  factory HomeServicesLeadModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesLeadModel(
      id: json['_id'] ?? '',
      serviceId: json['service_id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      note: json['note'] ?? '',
      answers: (json['answers'] as List? ?? [])
          .map((e) => HomeServicesAnswersModel.fromJson(e))
          .toList(),
      files: (json['files'] as List? ?? [])
          .map((e) => HomeServicesLeadFileModel.fromJson(e))
          .toList(),
      sendOption: json['send_option'] ?? 'top5',
      createdAt: DateTime.parse(
        json['created_at'] ?? json['createdAt'] ?? DateTime.now().toString(),
      ),
    );
  }
}
