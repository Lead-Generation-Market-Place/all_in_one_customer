import 'package:yelpax/features/home_services/data/models/home_services_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_professional_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_question_model.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';

import 'home_services_location_model.dart';

class HomeServicesFetchProfessionalModel
    extends HomeServicesFetchProfessionalsEntity {
  HomeServicesFetchProfessionalModel({
    required super.id,
    required super.serviceName,
    required super.maximumPrice,
    required super.minimumPrice,
    required super.serviceStatus,
    required super.description,
    required super.pricingType,
    required super.completedTasks,
    required super.createdAt,
    required super.updatedAt,
    required super.service,
    required super.professional,
    required super.locations,
    required super.questions,
  });

  factory HomeServicesFetchProfessionalModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HomeServicesFetchProfessionalModel(
      id: json["_id"] ?? "",
      serviceName: json["service_name"] ?? "",
      maximumPrice: json["maximum_price"] ?? 0,
      minimumPrice: json["minimum_price"] ?? 0,
      serviceStatus: json["service_status"] ?? false,
      description: json["description"] ?? "",
      pricingType: json["pricing_type"] ?? "",
      completedTasks: json["completed_tasks"] ?? 0,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      service: json["service_id"] != null
          ? HomeServicesModel.fromJson(json["service_id"])
          : HomeServicesModel.assignEmptyValues(),
      professional: json["professional_id"] != null
          ? HomeServicesProfessionalModel.fromJson(json['professional_id'])
          : HomeServicesProfessionalModel.empty(),
      locations:
          (json["location_ids"] as List?)
              ?.map((e) => HomeServicesLocationModel.fromJson(e))
              .toList() ??
          [],

      questions:
          (json["question_ids"] as List?)
              ?.map((e) => HomeServicesQuestionModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
