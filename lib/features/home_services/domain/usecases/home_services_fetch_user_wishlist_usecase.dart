import 'package:dartz/dartz.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

import '../../../../core/error/failures/failure.dart';
import '../entities/home_services_wishlist_entity.dart';

class HomeServicesFetchUserWishlistUsecase {
  HomeServicesRepository repository;
  HomeServicesFetchUserWishlistUsecase({required this.repository});

  Future<Either<Failure, List<HomeServicesWishlistEntity>>> call() {
    return repository.fetchUserWishlist();
  }
}