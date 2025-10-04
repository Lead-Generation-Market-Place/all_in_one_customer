class SigninEntity {
  String token;
  User user;
  SigninEntity({required this.token, required this.user});
}

class User {
  String id;
  String username;
  String email;
  User({required this.id, required this.username, required this.email});
}
