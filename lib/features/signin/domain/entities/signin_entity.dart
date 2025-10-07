class SigninEntity {
  Tokens tokens;
  User user;
  SigninEntity({required this.tokens, required this.user});
}

class User {
  String id;
  String username;
  String email;
  User({required this.id, required this.username, required this.email});
}

class Tokens {
  String accessToken;
  String refreshToken;
  Tokens({required this.accessToken, required this.refreshToken});
}
