class HomeServicesUserEntity {
  final String id;
  final String email;
  final String? phone;
  final String username;
  final String? description;
  HomeServicesUserEntity({
    required this.id,
    required this.email,
    this.phone = '',
    required this.username,
    this.description,
  });
}