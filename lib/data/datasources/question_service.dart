
import 'package:supabase_flutter/supabase_flutter.dart';

class QuestionService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Question>> fetchQuestions() async {
    final response = await client.from('questions').select();
    final data = List<Map<String, dynamic>>.from(response);
    return data.map((item) => Question.fromMap(item)).toList();
  }
}

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String category;
  final String difficulty;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.category,
    required this.difficulty,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'].toString(),
      text: map['text'] ?? '',
      options: List<String>.from(map['options']),
      correctIndex: map['correctIndex'],
      category: map['category'] ?? '',
      difficulty: map['difficulty'] ?? '',
    );
  }
}
