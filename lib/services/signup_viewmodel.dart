import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../providers/signup_provider.dart';

class SignupViewModel extends ChangeNotifier {
  final Ref ref;
  bool isLoading = false;
  String? errorMessage;

  SignupViewModel(this.ref);

  Future<void> signUp(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    
    try {
      final authService = ref.read(authServiceProvider); // this line authenticates the input using the provider
      await authService.signUp(email, password); // no need for SQL query lines, supabase does it
    } on AuthException catch (e) {
      errorMessage = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
