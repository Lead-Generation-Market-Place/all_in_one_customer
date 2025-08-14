import 'package:yelpax/features/home_services/domain/entities/professional.dart';

abstract class HomeServicesRepository {
  Future<List<Professional>> searchProfessionals(String query);
}
