import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';

class HomeServicesPromotionEntity {
  final String id;
  final String title;
  final String description;
  final String discount_type;
  final int discount_value;
  final String valid_from;
  final String valid_to;
  final bool is_active;
  final String promo_code;
  final HomeServicesEntity servicesEntity;

  HomeServicesPromotionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.discount_type,
    required this.discount_value,
    required this.valid_from,
    required this.valid_to,
    required this.is_active,
    required this.promo_code,
    required this.servicesEntity,
  });
}


