import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      if (email == "test@test.com" && password == "password") {
        state = const AuthState.authenticated();
      } else {
        state = const AuthState.error("Invalid credentials");
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
