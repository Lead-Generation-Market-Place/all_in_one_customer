import 'package:flutter/widgets.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_wishlist_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_fetch_user_wishlist_usecase.dart';

class HomeServicesWishlistController extends ChangeNotifier {
  HomeServicesFetchUserWishlistUsecase fetchUserWishlistUsecase;
  HomeServicesWishlistController({required this.fetchUserWishlistUsecase});

  //real states
  List<HomeServicesWishlistEntity> _wishlists = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<HomeServicesWishlistEntity> get wishlists => _wishlists;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch User Wishlist Methods
  Future<void> fetchUserWishlist() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await fetchUserWishlistUsecase.call();
      response.fold(
        (problem) {
          _error = problem.message;
          notifyListeners();
          print(problem.message);
        },
        (success) {
          _wishlists = success;
          notifyListeners();
          print(success);
        },
      );  

    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
