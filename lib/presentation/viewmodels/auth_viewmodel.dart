import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';

class AuthViewModel extends ChangeNotifier {
  final _supabase = SupabaseService();

  Future<bool> isLoggedIn() => _supabase.isLoggedIn();
  Future<String?> login(String email, String password) => _supabase.login(email, password);
  Future<String?> register(String email, String password) => _supabase.register(email, password);
  Future<void> logout() => _supabase.logout();
}
