import 'package:flutter/widgets.dart';
import '../../domain/entities/professional.dart';
import '../../domain/usecases/search_professional_usecase.dart';

import '../../../../config/routes/router.dart';

class SearchProfessionalController extends ChangeNotifier {
  final SearchProfessionalUsecase searchProfessionalUsecase;
  SearchProfessionalController({required this.searchProfessionalUsecase});

  List<Professional> professionals = [];
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
