// home_services_coordinates_model.dart
import 'package:yelpax/features/home_services/domain/entities/home_services_coordinates_entity.dart';

import 'home_services_CoordinatePoints_model.dart';


class HomeServicesCoordinatesModel extends HomeServicesCoordinatesEntity {
  HomeServicesCoordinatesModel({
    required super.type,
    required super.geoPoints,
  });

  factory HomeServicesCoordinatesModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesCoordinatesModel(
      type: json["type"] ?? "",
      geoPoints: json["coordinates"] != null
          ? HomeServicesCoordinatePointsModel.fromJson(
              List<double>.from(json["coordinates"]),
            )
          : HomeServicesCoordinatePointsModel.empty(),
    );
  }

  factory HomeServicesCoordinatesModel.empty() {
    return HomeServicesCoordinatesModel(
      type: "",
      geoPoints: HomeServicesCoordinatePointsModel.empty(),
    );
  }
}
