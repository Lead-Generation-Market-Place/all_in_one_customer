class HomeServicesEntity {

final String id;
final String service_name;
final String subcategory_id;
final bool service_status;
final String created_at;
final String updated_at;

  HomeServicesEntity({
    required this.id,
    required this.service_name,
    required this.subcategory_id,
    required this.service_status,
    required this.created_at,
    required this.updated_at
  });
}
