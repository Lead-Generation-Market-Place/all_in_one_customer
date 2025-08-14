import 'package:flutter/widgets.dart';
import 'package:yelpax/features/home_services/domain/entities/professional.dart';
import 'package:yelpax/features/home_services/domain/usecases/search_professional_usecase.dart';

class SearchProfessionalController extends ChangeNotifier {
  final SearchProfessionalUsecase searchProfessionalUsecase;
  SearchProfessionalController(this.searchProfessionalUsecase);

  List<Professional> result = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> search(String query) async {
    if (query.isEmpty) {
      result = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      result = await searchProfessionalUsecase(query);
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearResult() {
    result = [];
    notifyListeners();
  }
}
