import 'package:yelpax/features/home_services/domain/entities/home_services_user_entity.dart';

class HomeServicesProfessionalEntity {
  final String id;
  final HomeServicesUserEntity? user;
  final String businessName;
  final String introduction;
  final String businessType;
  final String profileImage;
  final int totalHire;
  final int totalReview;
  final int ratingAverage;


  HomeServicesProfessionalEntity({
    required this.id,
    this.user,
    required this.businessName,
    required this.introduction,
    required this.businessType,
    required this.profileImage,
    required this.totalHire,
    required this.totalReview,
    required this.ratingAverage
  });
}