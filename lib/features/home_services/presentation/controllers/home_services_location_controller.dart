import 'package:flutter/foundation.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_get_current_location_usecase.dart';

class HomeServicesLocationController with ChangeNotifier {
  final HomeServicesGetCurrentLocationUsecase getCurrentLocationUsecase;

  HomeServicesLocationController({required this.getCurrentLocationUsecase});

  // State
  HomeServicesLocationEntity? _currentLocation;
  bool _isLoading = false;
  String? _error;

  // Getters
  HomeServicesLocationEntity? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get hasLocation => _currentLocation != null;

  // Actions
  Future<void> getCurrentLocation() async {
    _setLoading(true);
    _error = null;
    notifyListeners();

    final result = await getCurrentLocationUsecase();

    result.fold(
      (failure) {
        _error = failure.message;
        _currentLocation = null;
      },
      (location) {
        _currentLocation = location;
        _error = null;
      },
    );

    _setLoading(false);
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearLocation() {
    _currentLocation = null;
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}