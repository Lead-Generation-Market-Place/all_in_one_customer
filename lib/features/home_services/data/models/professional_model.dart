import '../../domain/entities/professional.dart';

class ProfessionalModel extends Professional {
  const ProfessionalModel({required super.id, required super.name});

  factory ProfessionalModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalModel(id: json['id'] ?? '', name: json['name'] ?? '');
  }
}
