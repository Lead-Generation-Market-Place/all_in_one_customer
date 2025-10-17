import 'home_services_coordinate_points_entity.dart';

class HomeServicesCoordinatesEntity {
  final String type;
  final HomeServicesCoordinatePointsEntity geoPoints;

  HomeServicesCoordinatesEntity({
    required this.type,
    required this.geoPoints,
  });
}