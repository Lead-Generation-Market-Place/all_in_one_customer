import 'package:flutter/material.dart';
import 'package:yelpax/config/routes/router.dart';

class PromotionController extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  bool _refreshLoading = false;
  bool _categoryLoading = false;
  List _categories = [];
  PromotionController() {
    _scrollController.addListener(_scrollListener);
    getCategories();
  }

  ScrollController get scrollController => _scrollController;
  bool get refreshLoading => _refreshLoading;
  bool get categoryLoading => _categoryLoading;
  List get categories => _categories;

  void _scrollListener() {
    if (_scrollController.offset < -50 && !_refreshLoading) {
      retry();
    }
  }

  Future getCategories() async {
    try {
      _categoryLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 4));
      categories.add('Grocery');
      categories.add('Foods');
      categories.add('Shooping');
      categories.add('Home Services');
      categories.add('IT');
    } catch (e) {
      _categories = [];
      print('errr on _category loading');
    } finally {
      _categoryLoading = false;
      notifyListeners();
    }
  }

  openCategory(String title, BuildContext context) {
    switch (title) {
      case 'Grocery':
        return Navigator.pushNamed(context, AppRouter.grocery);
      case 'Home Services':
        return Navigator.pushNamed(context, AppRouter.homeServices);
    }
  }

  Future<void> retry() async {
    _refreshLoading = true;
    notifyListeners();
    try {
      await Future.delayed(Duration(seconds: 5));
    } catch (e) {
      print('❌ Error: $e');
    } finally {
      _refreshLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
