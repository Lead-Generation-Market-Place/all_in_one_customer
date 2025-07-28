import 'package:flutter/cupertino.dart';

class PromotionController extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController =>
      _scrollController; //Scroll Controller
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void onDispose() {
    print('disposed');
    _scrollController.dispose();
    _scrollController.removeListener(() => _scrollController);
  }

  void onInit() {
    _scrollController.addListener(() {
      if (_scrollController.offset < -50) {
        if (!_isLoading) {
          retry();
        }
      }
    });
  }

  Future retry() async {
    try {
      notifyListeners();
      _isLoading = true;
      await Future.delayed(Duration(seconds: 5));
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
      _isLoading = false;
    }
  }
}
