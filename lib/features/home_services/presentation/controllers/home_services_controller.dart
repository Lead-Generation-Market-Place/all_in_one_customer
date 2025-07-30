import 'package:flutter/material.dart';

class HomeServicesController extends ChangeNotifier {
  bool _categoryLoading = false;
  List _categories = [];

  bool get categoryLoading => _categoryLoading;
  List get categories => _categories;

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
    } catch (e) {
      _categories = [];
      print('errr on _category loading');
    } finally {
      _categoryLoading = false;
      notifyListeners();
    }
  }
}
