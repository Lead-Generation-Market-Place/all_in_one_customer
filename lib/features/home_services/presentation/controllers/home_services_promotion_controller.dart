import 'package:flutter/cupertino.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_promotions_usecase.dart';
import '../../domain/entities/home_services_promotion_entity.dart';

class HomeServicesPromotionController extends ChangeNotifier {
  HomeServicesPromotionsUsecase usecase;
  HomeServicesPromotionController({required this.usecase}) {
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

    final result = await usecase.getPromotionsUsecase();

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
