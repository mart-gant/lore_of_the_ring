
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lore_of_the_ring/services/firebase_auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService;
  late final StreamSubscription<User?> _authStateSubscription;

  AuthViewModel(this._authService) {
    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> signUp(String email, String password) async {
    await _authService.registerWithEmailAndPassword(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
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
