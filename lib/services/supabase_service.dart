
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;

  SupabaseService._internal();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://yrigyemwfirizebxurnh.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlyaWd5ZW13ZmlyaXplYnh1cm5oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4MjM3NzcsImV4cCI6MjA3ODM5OTc3N30.CtGYzH0UvsMo8quxS9yYV-F2GhmVfyoBEyWSgB5mtUw',
    );
  }

  SupabaseClient get client => Supabase.instance.client;

  // Example of a sign-up function
  Future<void> signUp(BuildContext context, String email, String password) async {
    try {
      final response = await client.auth.signUp(email: email, password: password);
      if (response.user != null) {
        // Navigate to home screen or show success message
      }
    } on AuthException catch (e) {
      // Show error message
    }
  }

  // Example of a login function
  Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      final response = await client.auth.signInWithPassword(email: email, password: password);
      if (response.user != null) {
        // Navigate to home screen
      }
    } on AuthException catch (e) {
      // Show error message
    }
  }

  // Example of a logout function
  Future<void> signOut(BuildContext context) async {
    await client.auth.signOut();
    // Navigate to login screen
  }
}
