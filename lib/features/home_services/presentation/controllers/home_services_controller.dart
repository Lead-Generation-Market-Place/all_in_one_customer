import 'package:flutter/material.dart';

class HomeServicesController extends ChangeNotifier {
  HomeServicesController() {
    _scrollController.addListener(_scrollListener);
  }
  bool _categoryLoading = false;
  bool _isAddressExists = false;
  List _categories = [];

  bool get categoryLoading => _categoryLoading;
  bool get isAddressExists => _isAddressExists;
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  List get categories => _categories;
  bool _refreshLoading = false;
  bool get refreshLoading => _refreshLoading;

  Future<void> retry() async {
    debugPrint('Loading ....');
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
      categories.add('Handy Man');
      categories.add('Home Cleaning');
      categories.add('Junk Removal');
      categories.add('Plumber');
      categories.add('TV Mounting');
      categories.add('See All');
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
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
