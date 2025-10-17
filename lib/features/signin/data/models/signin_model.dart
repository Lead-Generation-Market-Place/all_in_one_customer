import '../../domain/entities/signin_entity.dart';

class SigninModel extends SigninEntity {
  SigninModel({required super.tokens, required super.user});

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      tokens: Tokens(
        accessToken: json['tokens']['accessToken'] ?? "",
        refreshToken: json['tokens']['refreshToken'] ?? "",
      ),

      user: User(
        id: json['user']['id'] ?? "",
        username: json['user']['username'] ?? "",
        email: json['user']['email'] ?? "",
      ),
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': user.id,
        'username': user.username,
        'email': user.email,
      },
      'tokens': {
        'accessToken': tokens.accessToken,
        'refreshToken': tokens.refreshToken,
      },
    };
  }
}
