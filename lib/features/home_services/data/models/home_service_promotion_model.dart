import 'package:yelpax/features/home_services/data/models/home_services_model.dart';
import '../../domain/entities/home_services_promotion_entity.dart';

class HomeServicePromotionModel extends HomeServicesPromotionEntity {
  HomeServicePromotionModel({
    required super.id,
    required super.title,
    required super.description,
    required super.discount_type,
    required super.discount_value,
    required super.valid_from,
    required super.valid_to,
    required super.is_active,
    required super.promo_code,
    required super.servicesEntity
  });

  factory HomeServicePromotionModel.fromJson(Map<String, dynamic> json) {
    return HomeServicePromotionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discount_type: json['discount_type'],
      discount_value: json['discount_value'] ?? 0,
      valid_from: json['valid_from']?? '',
      valid_to: json['valid_to']?? '',
      is_active: json['is_active'] ?? false,
      promo_code: json['promo_code'] ?? '',
      servicesEntity: HomeServicesModel.fromJson(json['service_id'])
    );
  }
}
