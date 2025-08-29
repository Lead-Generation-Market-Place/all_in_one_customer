import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';

class HomeServicePromotionModel extends HomeServicesPromotionEntity {
  HomeServicePromotionModel({
    required super.id,
    required super.serviceName,
    required super.promotionName,
    required super.promotionImage,
    required super.serviceProviders,
  });

  factory HomeServicePromotionModel.fromJson(Map<String, dynamic> json) {
    return HomeServicePromotionModel(
      id: json['id'] ?? 0,
      serviceName: json['serviceName'] ?? '',
      promotionName: json['promotionName'] ?? '',
      promotionImage: json['promotionImage'],
      serviceProviders: json['serviceProviders'] ?? '',
    );
  }
}
