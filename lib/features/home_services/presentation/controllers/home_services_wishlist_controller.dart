import 'package:flutter/widgets.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_wishlist_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_wishlist_usecase.dart';

class HomeServicesWishlistController extends ChangeNotifier {
  HomeServicesWishlistUsecase homeServicesWishlistUsecase;
  HomeServicesWishlistController({required this.homeServicesWishlistUsecase});

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
    _error=null;//setting error to empty before fetching
    _isLoading = true;
    notifyListeners();
    try {
      final response = await homeServicesWishlistUsecase.call();
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

  Future<void> removeFromWishlist(String wishlistId) async {
    print(wishlistId);
    _error=null;//setting error to empty before fetching
    _isLoading = true;
    notifyListeners();
    try {
      final response = await homeServicesWishlistUsecase.removeFromWishlist(wishlistId);
      response.fold(
        (problem) {
          _error = problem.message;
          notifyListeners();
          print(problem.message);
        },
        (success) {
        _wishlists.removeWhere((item) => item.id == wishlistId);
          notifyListeners();
          print('Removed from wishlist successfully');
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
