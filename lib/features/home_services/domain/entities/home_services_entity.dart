class HomeServicesEntity {

final String id;
final String name;
final String slug;
final String subcategory_id;
final String description;
final String image_url;
final bool is_active;
final String created_at;
final String updated_at;

  HomeServicesEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.subcategory_id,
    required this.description,
    required this.image_url,
    required this.is_active,
    required this.created_at,
    required this.updated_at
  });
}
