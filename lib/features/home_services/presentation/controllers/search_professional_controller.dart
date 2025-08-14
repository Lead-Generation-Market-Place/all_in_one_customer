import 'package:flutter/widgets.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/professional.dart';
import 'package:yelpax/features/home_services/domain/usecases/search_professional_usecase.dart';

class SearchProfessionalController extends ChangeNotifier {
  final SearchProfessionalUsecase searchProfessionalUsecase;
  SearchProfessionalController(this.searchProfessionalUsecase);

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

  void clearResult() {
    professionals = [];
    notifyListeners();
  }
}
