// home_services_location_model.dart
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'home_services_coordinates_model.dart';

class HomeServicesLocationModel extends HomeServicesLocationEntity {
  HomeServicesLocationModel({
    required super.id,
    required super.type,
    required super.country,
    required super.state,
    required super.city,
    required super.zipCode,
    required super.addressLine,
    required super.createdAt,
    required super.updatedAt,
    required super.coordinates,
  });

  factory HomeServicesLocationModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesLocationModel(
      id: json["_id"] ?? "",
      type: json["type"] ?? "",
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      city: json["city"] ?? "",
      zipCode: json["zipcode"] ?? "",
      addressLine: json["address_line"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      coordinates: json["coordinates"] != null
          ? HomeServicesCoordinatesModel.fromJson(json["coordinates"])
          : HomeServicesCoordinatesModel.empty(),
    );
  }

  factory HomeServicesLocationModel.empty() {
    return HomeServicesLocationModel(
      id: "",
      type: "",
      country: "",
      state: "",
      city: "",
      zipCode: "",
      addressLine: "",
      createdAt: "",
      updatedAt: "",
      coordinates: HomeServicesCoordinatesModel.empty(),
    );
  }
}
