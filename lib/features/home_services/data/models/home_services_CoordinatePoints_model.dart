// home_services_coordinate_points_model.dart
import 'package:yelpax/features/home_services/domain/entities/home_services_coordinate_points_entity.dart';

class HomeServicesCoordinatePointsModel
    extends HomeServicesCoordinatePointsEntity {
  HomeServicesCoordinatePointsModel({
    required super.longitude,
    required super.latitude,
  });

  factory HomeServicesCoordinatePointsModel.fromJson(List<dynamic> json) {
   
    return HomeServicesCoordinatePointsModel(
      longitude: (json.isNotEmpty ? json[0] : 0).toDouble(),
      latitude: (json.length > 1 ? json[1] : 0).toDouble(),
    );
  }

  factory HomeServicesCoordinatePointsModel.empty() {
    return HomeServicesCoordinatePointsModel(longitude: 0, latitude: 0);
  }
}
