
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lore_of_the_ring/domain/entities/score.dart';

class ScoreService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Save a new score
  Future<void> saveScore(int score, String userId) async {
    try {
      await _supabase.from('scores').insert({
        'score': score,
        'user_id': userId,
      });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Fetch the top scores for the leaderboard
  Future<List<Score>> getLeaderboard() async {
    try {
      final response = await _supabase
          .from('scores')
          .select()
          .order('score', ascending: false)
          .limit(10); // Get top 10 scores

      final scores = (response as List)
          .map((json) => Score.fromJson(json))
          .toList();

      return scores;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
