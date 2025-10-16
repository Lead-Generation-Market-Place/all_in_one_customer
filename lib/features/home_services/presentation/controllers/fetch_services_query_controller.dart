import 'package:flutter/widgets.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import '../../domain/usecases/fetch_services_query_usecase.dart';

import '../../../../config/routes/router.dart';

class FetchServicesQueryController extends ChangeNotifier {
  final SearchProfessionalUsecase searchProfessionalUsecase;
  FetchServicesQueryController({required this.searchProfessionalUsecase});

  List<HomeServicesEntity> professionals = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> search(String query) async {
    if (query.isEmpty) {
      professionals = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    final result = await searchProfessionalUsecase(query);
    result.fold(
      (Failure) => errorMessage = Failure.message,
      (data) => professionals = data,
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    Navigator.pushNamed(
      context,
      AppRouter.serviceProfessionalsScreen,
      arguments: categoryDetails,
    );
  }

  void clearResult() {
    professionals = [];
    notifyListeners();
  }
}
