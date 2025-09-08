import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../../../config/routes/router.dart';

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

      categories.add({
        'name': 'Handy Man',
        'imageUrl':
            'https://images.pexels.com/photos/12725415/pexels-photo-12725415.jpeg',
      });
      categories.add({
        'name': 'Home Cleaning',
        'imageUrl':
            'https://images.pexels.com/photos/4239146/pexels-photo-4239146.jpeg',
      });
      categories.add({
        'name': 'Junk Removal',
        'imageUrl':
            'https://images.pexels.com/photos/2409022/pexels-photo-2409022.jpeg',
      });
      categories.add({
        'name': 'Plumber',
        'imageUrl':
            'https://images.pexels.com/photos/33699778/pexels-photo-33699778.jpeg',
      });
      categories.add({
        'name': 'TV Mounting',
        'imageUrl':
            'https://images.pexels.com/photos/7546319/pexels-photo-7546319.jpeg',
      });
      categories.add({
        'name': 'Applicance service specialists',
        'imageUrl':
            'https://images.pexels.com/photos/7979605/pexels-photo-7979605.jpeg',
      });
      categories.add({
        'name': 'See All',
        'imageUrl':
            'https://images.pexels.com/photos/6185434/pexels-photo-6185434.jpeg',
      });
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
