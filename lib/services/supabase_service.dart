import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<bool> isLoggedIn() async {
    return client.auth.currentUser != null;
  }

  Future<String?> login(String email, String password) async {
    try {
      final res = await client.auth.signInWithPassword(email: email, password: password);
      return res.session == null ? 'Nie udało się zalogować' : null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Nieznany błąd: $e';
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      final res = await client.auth.signUp(email: email, password: password);
      return res.user == null ? 'Nie udało się zarejestrować' : null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Nieznany błąd: $e';
    }
  }

  Future<void> logout() async {
    await client.auth.signOut();
  }

  Future<List<Map<String, dynamic>>> getQuestions() async {
    final res = await client.from('questions').select();
    return List<Map<String, dynamic>>.from(res);
  }

  Future<void> submitAnswer(String question, String answer, bool correct) async {
    final user = client.auth.currentUser;
    if (user == null) return;
    await client.from('answers').insert({
      'question': question,
      'answer': answer,
      'correct': correct,
      'user_id': user.id,
    });
  }
}
