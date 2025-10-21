import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_usecase.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_location_controller.dart';
import '../../../../config/routes/router.dart';

class HomeServicesController extends ChangeNotifier {
  HomeServicesUsecase homeServicesUsecase;
  HomeServicesLocationController locationData;
  HomeServicesController({required this.homeServicesUsecase,required this.locationData});

  //real states
  List<HomeServicesEntity> _homeServices = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  // Getters
  List<HomeServicesEntity> get homeServices => _homeServices;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  // Fetch home services Methods
  Future<void> fetchPopularHomeServices() async {
    _isLoading = true;
    notifyListeners();
    final response = await homeServicesUsecase.call();
    response.fold(
      (problem) {
        _error = problem.message;
        _isLoading = false;
        notifyListeners();
      },
      (success) {
        _homeServices = success;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
    // Fetch home services Methods
  Future<void> fetchAllHomeServices() async {
    _isLoading = true;
    notifyListeners();
    final response = await homeServicesUsecase.all();
    response.fold(
      (problem) {
        _error = problem.message;
        _isLoading = false;
        notifyListeners();
      },
      (success) {
        _homeServices = success;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

//opening a service from home screen of home services
  Future<void> openService(Map service) async {
    if (service['name'] == 'See All') {
      AppConstants.navigateKeyword.currentState?.pushNamed(
        AppRouter.seeAllServices,
        arguments: _categories,
      );
    } else {
       
      AppConstants.navigateKeyword.currentState?.pushNamed(
        AppRouter.serviceProfessionalsScreen,
        arguments: {
          'serviceId':service['id'],
          'serviceName':service['name'],
          'zipCode':service['zipCode'] ?? '',
          'imageUrl':service['imageUrl'],
        }

      );
    }
  }

  bool _categoryLoading = false;
  bool _isAddressExists = false;
  List _categories = [];

  bool get categoryLoading => _categoryLoading;
  bool get isAddressExists => _isAddressExists;

  List get categories => _categories;
  bool _refreshLoading = false;
  bool get refreshLoading => _refreshLoading;

  Future<void> retry() async {
    _refreshLoading = true;
    notifyListeners();
    try {
      await Future.delayed(Duration(seconds: 5));
      SmartDialog.showToast('Data Loaded Successfully');
      debugPrint('Data Loaded ....');
    } catch (e) {
      print('❌ Error: $e');
    } finally {
      _refreshLoading = false;
      notifyListeners();
    }
  }

 
  @override
  void dispose() {
    super.dispose();
  }
}
