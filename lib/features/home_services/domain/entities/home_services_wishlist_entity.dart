import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';

class HomeServicesWishlistEntity {
  final String id;
  final String userId;
  final HomeServicesEntity homeServicesEntity;
  final DateTime createdAt;
  final DateTime updatedAt;

 const HomeServicesWishlistEntity({
  required this.id,
  required this.userId,
  required this.homeServicesEntity,
  required this.createdAt,
  required this.updatedAt
  });
}