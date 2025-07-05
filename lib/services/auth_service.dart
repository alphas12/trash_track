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

  Future<AuthResponse> login(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    return await client.auth.signOut();
  }

  User? get currentUser => client.auth.currentUser;

  Session? get currentSession => client.auth.currentSession;
}
