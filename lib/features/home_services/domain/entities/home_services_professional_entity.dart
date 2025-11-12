import 'package:yelpax/features/home_services/domain/entities/home_services_user_entity.dart';

class HomeServicesProfessionalEntity {
  final String id;
  final HomeServicesUserEntity? user;
  final String businessName;
  final String introduction;
  final String businessType;
  final String? website;
  final int? founded_year;
  final int? employees;
  final String profileImage;
  final int totalHire;
  final int totalReview;
  final int ratingAverage;
  final List? payment_methods;
  final List? portfolio;
  final List? specializations;
  final String? createdAt;
  final String? updatedAt;

  HomeServicesProfessionalEntity({
    required this.id,
    this.user,
    required this.businessName,
    required this.introduction,
    required this.businessType,
     this.website,
     this.founded_year,
     this.employees,
    required this.profileImage,
    required this.totalHire,
    required this.totalReview,
    required this.ratingAverage,
    this.payment_methods,
    this.portfolio,
    this.specializations,
    this.createdAt,
    this.updatedAt
  });
}