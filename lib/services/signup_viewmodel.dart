import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class SignUpViewModel extends ChangeNotifier {
  final Ref ref;
  SignUpViewModel(this.ref);

  bool isLoading = false;
  String? errorMessage;

  Future<void> signUp({
    required String email,
    required String password,
    required String fname,
    required String lname,
    required String location,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signUpWithCredentials(
        email: email.trim(),
        password: password,
        fname: fname,
        lname: lname,
        location: location,
      );
    } catch (e) {
      errorMessage = "Sign up failed: ${e.toString()}";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
