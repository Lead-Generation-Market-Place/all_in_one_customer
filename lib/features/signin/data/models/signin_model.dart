import '../../domain/entities/signin_entity.dart';

class SigninModel extends SigninEntity {
  SigninModel({required super.token, required super.user});

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      token: json['token'] ?? "",
      user: User(
        id: json['id'] ?? "",
        username: json['username'] ?? "",
        email: json['email'] ?? "",
      ),
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "id":user.id,
      "username":user.username,
      "email":user.email
    };
  }
}
