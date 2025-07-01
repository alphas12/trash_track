import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
    );
    return response;
  }
}
