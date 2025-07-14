import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Expose current session and user
  Session? get currentSession => _client.auth.currentSession;
  User? get currentUser => _client.auth.currentUser;

  // Optional: Listen to session changes (e.g. for logout or refresh tokens)
  void listenToAuthChanges(Function(AuthChangeEvent event, Session? session)? callback) {
    _client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;
      if (callback != null) callback(event, session);
    });
  }

  Future<void> signUpWithCredentials({
    required String email,
    required String password,
    required String fname,
    required String lname,
    required String location,
  }) async {

    if (email.trim().isEmpty || password.isEmpty) {
      throw Exception("Email and password cannot be empty");
    }

    final authResponse = await _client.auth.signUp(email: email.trim(), password: password);
    final user = authResponse.user;

    if (user != null) {
      final String userCredId = user.id;
      final String userInfoId = const Uuid().v4();
      final String userEmail = user.email ?? '';


      // 1. Insert into user_info
      final info = UserInfoModel(
        userInfoId: userInfoId,
        fname: fname,
        lname: lname,
        location: location,
        authId: userCredId, // Store auth user ID
      );

      await _client.from('user_info').insert(info.toMap());

      // 2. Insert into user_credentials
      await _client.from('user_credentials').insert({
        'user_cred_id': userCredId,
        'user_email': userEmail,
        'user_password': password, // optional: omit if using Supabase Auth only
        'user_info_id': userInfoId,
      });
    }
  }

  Future<void> signIn(String email, String password) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
