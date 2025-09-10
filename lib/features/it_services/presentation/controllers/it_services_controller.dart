import 'package:flutter/material.dart';
import 'package:yelpax/features/it_services/domain/entities/it_services_entity.dart';
import 'package:yelpax/features/it_services/domain/usecases/it_services_usecase.dart';

class ItServicesController extends ChangeNotifier {
  ItServicesUsecase usecase;
  ItServicesController(this.usecase);
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ItServicesEntity> _itServices = [];
  List<ItServicesEntity> get itServices => _itServices;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    // Navigator.pushNamed(
    //   context,
    //   AppRouter.serviceProfessionalsScreen,
    //   arguments: categoryDetails,
    // );
  }

  Future<void> onChanged(String query) async {
  //  print(query);
    _isLoading = true;
    notifyListeners();

    final result = await usecase.onChanged(query);
    result.fold(
      (error) {
        _errorMessage = error.message;
        notifyListeners();
      },
      (success) {
        _itServices = success;
      },
    );
    _isLoading=false;
    notifyListeners();
  }

  void clearResult() {
    _itServices = [];
    notifyListeners();
  }
}
