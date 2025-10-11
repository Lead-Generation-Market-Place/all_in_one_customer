import 'package:yelpax/features/home_services/domain/entities/home_services_user_entity.dart';

class HomeServicesUserModel extends HomeServicesUserEntity {
  HomeServicesUserModel({
    required super.id,
    required super.email,
    required super.username,
  });

  factory HomeServicesUserModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesUserModel(
      id: json["_id"],
      email: json["email"],
      username: json["username"],
    );
  }

  factory HomeServicesUserModel.empty() {
    return HomeServicesUserModel(id: '', email: '', username: '');
  }
}
