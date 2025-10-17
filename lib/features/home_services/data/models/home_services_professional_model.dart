import 'package:yelpax/features/home_services/data/models/home_services_user_model.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_professional_entity.dart';

import '../../domain/entities/home_services_user_entity.dart';

class HomeServicesProfessionalModel extends HomeServicesProfessionalEntity {
  HomeServicesProfessionalModel({
    required super.id,
    HomeServicesUserEntity? user,
    required super.businessName,
    required super.introduction,
    required super.businessType,
    required super.profileImage,
    required super.totalHire,
    required super.totalReview,
    required super.ratingAverage
  });

  factory HomeServicesProfessionalModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesProfessionalModel(
      id: json["_id"] ?? "",
      user: json['user_id'] != null
          ? HomeServicesUserModel.fromJson(json['user_id'])
          : HomeServicesUserModel.empty(),
      businessName: json["business_name"] ?? "",
      introduction: json["introduction"] ?? "",
      businessType: json["business_type"] ?? "",
      profileImage: json["profile_image"] ?? "",
      totalHire: json["total_hire"]??0,
      totalReview: json["total_review"]??0,
      ratingAverage: json["rating_avg"]??0

    );
  }

  factory HomeServicesProfessionalModel.empty() {
    return HomeServicesProfessionalModel(
      id: '',
      user: HomeServicesUserModel.empty(),
      businessName: '',
      introduction: '',
      businessType: '',
      profileImage: '',
      totalHire: 0,
      totalReview: 0,
      ratingAverage: 0
    );
  }
}
