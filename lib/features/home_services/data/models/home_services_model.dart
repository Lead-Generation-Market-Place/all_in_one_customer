import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';

class HomeServicesModel extends HomeServicesEntity {
  HomeServicesModel({
    required super.id,
    required super.service_name,
    required super.subcategory_id,
    required super.service_status,
    required super.created_at,
    required super.updated_at,
  });

  factory HomeServicesModel.fromJson(Map json) {
    return HomeServicesModel(
      id: json['id'] ?? "",
      service_name: json["service_name"] ?? "",
      subcategory_id: json["subcategory_id"] ?? "",
      service_status: json["service_status"] ?? false,
      created_at: json["created_at"] ?? "",
      updated_at: json["updated_at"] ?? "",
    );
  }
}
