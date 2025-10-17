import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';

import 'home_services_location_entity.dart';
import 'home_services_professional_entity.dart';
import 'home_services_question_entity.dart';

class HomeServicesFetchProfessionalsEntity {
  final String id;
  final String serviceName;
  final int maximumPrice;
  final int minimumPrice;
  final bool serviceStatus;
  final String description;
  final String pricingType;
  final int completedTasks;
  final String createdAt;
  final String updatedAt;
  final HomeServicesEntity service;
  final HomeServicesProfessionalEntity professional;
  final List<HomeServicesLocationEntity> locations;
  final List<HomeServicesQuestionEntity> questions;

  HomeServicesFetchProfessionalsEntity({
    required this.id,
    required this.professional,
    required this.service,
    required this.serviceName,
    required this.maximumPrice,
    required this.minimumPrice,
    required this.serviceStatus,
    required this.description,
    required this.pricingType,
    required this.completedTasks,
    required this.createdAt,
    required this.updatedAt,
    required this.locations,
    required this.questions,
  });
}













