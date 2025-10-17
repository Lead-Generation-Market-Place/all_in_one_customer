import 'home_services_coordinates_entity.dart';

class HomeServicesLocationEntity {
  final String id;
  final String type;
  final String country;
  final String state;
  final String city;
  final String zipCode;
  final String addressLine;
  final String createdAt;
  final String updatedAt;
  final HomeServicesCoordinatesEntity coordinates;

  HomeServicesLocationEntity({
    required this.id,
    required this.type,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.addressLine,
    required this.createdAt,
    required this.updatedAt,
    required this.coordinates,
  });
}