// Create a model class for type safety
class ServiceProfessionalEntity {
  final String name;
  final double ratings;
  final int starsCount;
  final bool isActive;
  final String response;
  final int timesHired;
  final String estimatedPrice;
  final String? lastReviewText;
  final String? avatarUrl;

  ServiceProfessionalEntity({
    required this.name,
    required this.ratings,
    required this.starsCount,
    required this.isActive,
    required this.response,
    required this.timesHired,
    required this.estimatedPrice,
    this.lastReviewText,
    this.avatarUrl,
  });

  // Optional: Add fromMap constructor if you're getting data from JSON
  factory ServiceProfessionalEntity.fromMap(Map map) {
    return ServiceProfessionalEntity(
      name: map['name'] ?? '',
      ratings: (map['ratings'] ?? 0.0).toDouble(),
      starsCount: map['starsCount'] ?? 0,
      isActive: map['isActive'] ?? false,
      response: map['response']?.toString() ?? '0',
      timesHired: map['timesHired'] ?? 0,
      estimatedPrice: map['estimatedPrice'] ?? '',
      lastReviewText: map['lastReviewText'],
      avatarUrl: map['avatarUrl'],
    );
  }
}
