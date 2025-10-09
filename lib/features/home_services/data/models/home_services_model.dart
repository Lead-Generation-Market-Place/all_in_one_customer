import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';

class HomeServicesModel extends HomeServicesEntity {
  HomeServicesModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.subcategory_id,
    required super.description,
    required super.image_url,
    required super.is_active,
    required super.created_at,
    required super.updated_at,
  });

  factory HomeServicesModel.fromJson(Map json) {
    return HomeServicesModel(
      id: json['id'] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"]?? "",
      subcategory_id: json["subcategory_id"] ?? "",
      description: json["description"] ?? "",
      image_url: json["image_url"]??"",
      is_active: json["is_active"],
      created_at: json["created_at"] ?? "",
      updated_at: json["updated_at"] ?? "",
    );
  }
}
