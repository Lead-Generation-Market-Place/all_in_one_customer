import 'package:yelpax/features/home_services/data/datasources/home_services_promotion_remote_data_source.dart';
import 'package:yelpax/features/home_services/data/repositories/home_services_promotions_repository_impl.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_service_promotion_usecase.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_promotion_controller.dart';

HomeServicesPromotionController getPromotionDi() {
  final datasource = HomeServicesPromotionRemoteDataSourceImpl();
  final repo = HomeServicesPromotionsRepositoryImpl(datasource);
  final usecase = HomeServicePromotionUsecase(repo);
  return HomeServicesPromotionController(usecase);
}
