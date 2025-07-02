import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/signup_viewmodel.dart';

// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final signupViewModelProvider =
    ChangeNotifierProvider((ref) => SignupViewModel(ref));

// // Signup ViewModel provider
// final signupViewModelProvider = ChangeNotifierProvider(
//   (ref) => SignupViewModel(ref.read),
// );
