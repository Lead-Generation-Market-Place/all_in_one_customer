import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yelpax/config/routes/router.dart';

class HomeServicesController extends ChangeNotifier {
  HomeServicesController() {}

  bool _categoryLoading = false;
  bool _isAddressExists = false;
  List _categories = [];

  bool get categoryLoading => _categoryLoading;
  bool get isAddressExists => _isAddressExists;

  List get categories => _categories;
  bool _refreshLoading = false;
  bool get refreshLoading => _refreshLoading;

  Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    Navigator.pushNamed(
      context,
      AppRouter.serviceProfessionalsScreen,
      arguments: categoryDetails,
    );
  }

  Future<void> retry() async {
    _refreshLoading = true;
    notifyListeners();
    try {
      await Future.delayed(Duration(seconds: 5));
      SmartDialog.showToast('Data Loaded Successfully');
      debugPrint('Data Loaded ....');
    } catch (e) {
      print('❌ Error: $e');
    } finally {
      _refreshLoading = false;
      notifyListeners();
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
    super.dispose();
  }
}
