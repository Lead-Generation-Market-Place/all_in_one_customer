import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_usecase.dart';
import '../../../../config/routes/router.dart';

class HomeServicesController extends ChangeNotifier {
  HomeServicesUsecase homeServicesUsecase;
  HomeServicesController({required this.homeServicesUsecase});

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
  Future<void> fetchHomeServices() async {
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

  Future getCategories() async {
    try {
      _categoryLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 4));

      categories.add({
        'name': 'Handy Man',
        'imageUrl':
            'https://images.pexels.com/photos/12725415/pexels-photo-12725415.jpeg',
      });
      categories.add({
        'name': 'Home Cleaning',
        'imageUrl':
            'https://images.pexels.com/photos/4239146/pexels-photo-4239146.jpeg',
      });
      categories.add({
        'name': 'Junk Removal',
        'imageUrl':
            'https://images.pexels.com/photos/2409022/pexels-photo-2409022.jpeg',
      });
      categories.add({
        'name': 'Plumber',
        'imageUrl':
            'https://images.pexels.com/photos/33699778/pexels-photo-33699778.jpeg',
      });
      categories.add({
        'name': 'TV Mounting',
        'imageUrl':
            'https://images.pexels.com/photos/7546319/pexels-photo-7546319.jpeg',
      });
      categories.add({
        'name': 'Applicance service specialists',
        'imageUrl':
            'https://images.pexels.com/photos/7979605/pexels-photo-7979605.jpeg',
      });
      categories.add({
        'name': 'See All',
        'imageUrl':
            'https://images.pexels.com/photos/6185434/pexels-photo-6185434.jpeg',
      });
      // _isAddressExists = true;
    } catch (e) {
      _categories = [];
      print('errr on _category loading');
    } finally {
      _categoryLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
