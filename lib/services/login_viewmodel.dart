import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trash_track/screens/dashboard_screen.dart';
import 'package:trash_track/screens/settings_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final Ref ref;
  LoginViewModel(this.ref);

  bool isLoading = false;
  String? errorMessage;

  Future<String?> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signIn(email, password);

      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) return null;

      final userType = await Supabase.instance.client
        .from('user_credentials')
        .select('user_type')
        .eq('user_cred_id', userId)
        .maybeSingle();

        print('Debug: $userType');

      return userType?['user_type'];

    } catch (e) {
      errorMessage = "Login failed. Please check your credentials.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
