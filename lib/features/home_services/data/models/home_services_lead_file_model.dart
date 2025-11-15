import 'package:yelpax/features/home_services/domain/entities/home_services_lead_file_entity.dart';

class HomeServicesLeadFileModel extends HomeServicesLeadFileEntity {
  HomeServicesLeadFileModel({
    required super.url,
    required super.type,
    required super.originalName,
  });

  factory HomeServicesLeadFileModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesLeadFileModel(
      url: json['url'] ?? '',
      type: json['type'] ?? 'file',
      originalName: json['originalName'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'url': url, 'type': type, 'originalName': originalName};
  }
}
