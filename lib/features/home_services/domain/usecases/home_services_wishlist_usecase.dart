import 'package:dartz/dartz.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

import '../../../../core/error/failures/failure.dart';
import '../entities/home_services_wishlist_entity.dart';

class HomeServicesWishlistUsecase {
  HomeServicesRepository repository;
  HomeServicesWishlistUsecase({required this.repository});

  Future<Either<Failure, List<HomeServicesWishlistEntity>>> call() {
    return repository.fetchUserWishlist();
  }
  Future<Either<Failure, void>> removeFromWishlist(String wishlistId) {
    return repository.removeFromWishlist(wishlistId);
  }

  Future<Either<Failure,void>> addToWishlist(String serviceId) {
    return repository.addToWishlist(serviceId);
  }

}