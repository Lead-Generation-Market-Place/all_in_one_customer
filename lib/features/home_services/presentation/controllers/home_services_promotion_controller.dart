import 'package:flutter/cupertino.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_service_promotion_usecase.dart';

class HomeServicesPromotionController extends ChangeNotifier {
  HomeServicePromotionUsecase _usecase;
  HomeServicesPromotionController(this._usecase);

  bool _isPromotionLoading = false;
  bool get isPromotionLoading => _isPromotionLoading;

  String _failure = '';
  String get failure => _failure;

  List<HomeServicesPromotionEntity> _promotions = [];
  List get promotions => _promotions;

  Future getPromotions() async {
    _isPromotionLoading = true;
    notifyListeners();

    final result = await _usecase.call();

    result.fold(
      (error) {
        _failure = error.message;
      },
      (success) {
        _promotions = success;
      },
    );
    _isPromotionLoading = false;
    notifyListeners();
  }
}
