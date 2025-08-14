import 'package:yelpax/features/home_services/domain/entities/professional.dart';

class ProfessionalModel extends Professional {
  const ProfessionalModel({
    required super.id,
    required super.name,
    required super.serviceType,
  });

  factory ProfessionalModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      serviceType: json['serviceType'] ?? '',
    );
  }
}
