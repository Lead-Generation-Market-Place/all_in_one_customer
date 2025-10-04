import 'package:flutter/cupertino.dart';
import '../../domain/entities/home_services_promotion_entity.dart';
import '../../domain/usecases/home_service_promotion_usecase.dart';

class HomeServicesPromotionController extends ChangeNotifier {
  HomeServicePromotionUsecase _usecase;
  HomeServicesPromotionController(this._usecase) {
    getPromotions();
  }

  bool _isPromotionLoading = false;
  bool get isPromotionLoading => _isPromotionLoading;

  String _failure = '';
  String get failure => _failure;

  List<HomeServicesPromotionEntity> _promotions = [];
  List<HomeServicesPromotionEntity> get promotions => _promotions;

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
    print('Data Fetched ${promotions}');
    _isPromotionLoading = false;
    notifyListeners();
  }
}
