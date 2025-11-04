import 'package:flutter/widgets.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_wishlist_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_wishlist_usecase.dart';

import '../../domain/entities/home_services_entity.dart';
class HomeServicesWishlistController extends ChangeNotifier {
  HomeServicesWishlistUsecase homeServicesWishlistUsecase;
  HomeServicesWishlistController({required this.homeServicesWishlistUsecase});

  List<HomeServicesWishlistEntity> _wishlists = [];
  bool _isLoading = false;
  String? _error;

  List<HomeServicesWishlistEntity> get wishlists => _wishlists;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Add to wishlist
  Future<void> addToWishlist(HomeServicesEntity service) async {
    _error = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await homeServicesWishlistUsecase.addToWishlist(service.id);
      response.fold(
        (problem) {
          _error = problem.message;
          notifyListeners();
        },
        (success) {
          // Fetch updated wishlist after adding
          fetchUserWishlist();
        },
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Remove from wishlist
  Future<void> removeFromWishlist(String wishlistId) async {
    _error = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await homeServicesWishlistUsecase.removeFromWishlist(wishlistId);
      response.fold(
        (problem) {
          _error = problem.message;
          notifyListeners();
        },
        (success) {
          _wishlists.removeWhere((item) => item.id == wishlistId);
          notifyListeners();
        },
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  // Remove by service ID (useful for homepage)
  Future<void> removeFromWishlistByServiceId(String serviceId) async {
    final wishlistItem = _wishlists.firstWhere(
      (item) => item.homeServicesEntity.id == serviceId,
   
    );
    
    if (wishlistItem != null) {
      await removeFromWishlist(wishlistItem.id);
    }
  }

  // Check if service is wishlisted
  bool isWishlisted(String serviceId) {
    return _wishlists.any((element) => element.homeServicesEntity.id == serviceId);
  }

  // Toggle wishlist status
  Future<void> toggleWishlist(HomeServicesEntity service) async {
    if (isWishlisted(service.id)) {
      await removeFromWishlistByServiceId(service.id);
    } else {
      await addToWishlist(service);
    }
  }

  // Fetch wishlist (existing method)
  Future<void> fetchUserWishlist() async {
    _error = null;
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await homeServicesWishlistUsecase.call();
      response.fold(
        (problem) {
          _error = problem.message;
          notifyListeners();
        },
        (success) {
          _wishlists = success;
          notifyListeners();
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