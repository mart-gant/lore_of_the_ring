
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lore_of_the_ring/domain/models/question.dart';

class QuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Question>> getQuestions() async {
    try {
      final snapshot = await _firestore.collection('questions').get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      final questions = snapshot.docs.map((doc) => Question.fromJson(doc.data())).toList();
      return questions;
    } catch (e) {
      // You might want to handle errors more gracefully
      return [];
    }
  }
}
