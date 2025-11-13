
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lore_of_the_ring/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  late final StreamSubscription<AuthState> _authStateSubscription;

  AuthViewModel(this._authService) {
    _authStateSubscription = _authService.authStateChanges.listen((data) {
      final User? user = data.session?.user;
      _user = user;
      notifyListeners();
    });
  }

  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> signUp(String email, String password) async {
    await _authService.signUp(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await _authService.signIn(email, password);
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}
