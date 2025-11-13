
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Stream to listen for auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Get the current user
  User? get currentUser => _supabase.auth.currentUser;

  // Sign up a new user
  Future<void> signUp(String email, String password) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      // Consider using a more robust error handling/logging mechanism
      print(e.message);
      rethrow;
    }
  }

  // Sign in an existing user
  Future<void> signIn(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
