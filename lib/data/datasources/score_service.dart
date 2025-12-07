
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lore_of_the_ring/domain/entities/score.dart';

class ScoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save a new score
  Future<void> saveScore(int score, String userId) async {
    try {
      await _firestore.collection('scores').add({
        'score': score,
        'user_id': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Fetch the top scores for the leaderboard
  Future<List<Score>> getLeaderboard() async {
    try {
      final snapshot = await _firestore
          .collection('scores')
          .orderBy('score', descending: true)
          .limit(10) // Get top 10 scores
          .get();

      final scores = snapshot.docs
          .map((doc) => Score.fromJson(doc.data()))
          .toList();

      return scores;
    } catch (e) {
      rethrow;
    }
  }
}
