
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnswerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveAnswer({
    required String questionId,
    required int selectedIndex,
    required bool isCorrect,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not logged in');

    await _firestore.collection('answers').add({
      'user_id': userId,
      'question_id': questionId,
      'selected_index': selectedIndex,
      'is_correct': isCorrect,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
