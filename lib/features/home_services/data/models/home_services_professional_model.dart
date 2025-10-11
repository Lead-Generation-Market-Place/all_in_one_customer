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
  });

  factory HomeServicesProfessionalModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesProfessionalModel(
      id: json["_id"] ?? "",
      user: json['user_id'] != null
          ? HomeServicesUserModel.fromJson(json['user_id'])
          : HomeServicesUserModel.empty(),
      businessName: json["businessName"] ?? "",
      introduction: json["introduction"] ?? "",
      businessType: json["businessType"] ?? "",
      profileImage: json["profileImage"] ?? "",
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
    );
  }
}
