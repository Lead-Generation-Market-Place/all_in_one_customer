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
}
