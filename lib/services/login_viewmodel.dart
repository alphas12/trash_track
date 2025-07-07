import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginViewModel extends ChangeNotifier {
  final Ref ref;
  LoginViewModel(this.ref);

  bool isLoading = false;
  String? errorMessage;

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signIn(email, password);
    } catch (e) {
      errorMessage = "Login failed. Please check your credentials.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
