import 'package:yelpax/features/signin/domain/entities/signin_entity.dart';

class SigninModel extends SigninEntity {
  SigninModel({required super.token, required super.email});

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(token: json['token'], email: json['email']);
  }
}
