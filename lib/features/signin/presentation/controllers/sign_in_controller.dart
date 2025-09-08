import 'package:flutter/material.dart';
import '../../domain/entities/signin_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';

class SignInController extends ChangeNotifier {
  final SignInUseCase signInUseCase;

  SignInController(this.signInUseCase);

  bool isLoading = false;
  String? error;
  SigninEntity? user;

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await signInUseCase(email, password);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
