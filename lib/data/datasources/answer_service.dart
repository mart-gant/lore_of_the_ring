
import 'package:supabase_flutter/supabase_flutter.dart';

class AnswerService {
  final SupabaseClient client = Supabase.instance.client;

  Future<void> saveAnswer({
    required String questionId,
    required int selectedIndex,
    required bool isCorrect,
  }) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) throw Exception('Brak zalogowanego użytkownika');

    await client.from('answers').insert({
      'user_id': userId,
      'question_id': questionId,
      'selected_index': selectedIndex,
      'is_correct': isCorrect,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
