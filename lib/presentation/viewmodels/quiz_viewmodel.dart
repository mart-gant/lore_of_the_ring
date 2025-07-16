import 'package:flutter/material.dart';
import '../../domain/models/question.dart';
import '../../services/supabase_service.dart';

class QuizViewModel extends ChangeNotifier {
  final _supabase = SupabaseService();
  final List<Question> _questions = [];
  int _currentIndex = 0;

  Question? get currentQuestion => (_currentIndex < _questions.length) ? _questions[_currentIndex] : null;

  void loadNextQuestion() async {
    if (_questions.isEmpty) {
      final data = await _supabase.getQuestions();
      _questions.addAll(data.map((q) => Question.fromMap(q)));
    }

    if (_currentIndex + 1 < _questions.length) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    notifyListeners();
  }

  Future<bool> submitAnswer(String answer) async {
    final question = currentQuestion;
    final correct = question?.correctAnswer == answer;
    if (question != null) {
      await _supabase.submitAnswer(question.text, answer, correct);
    }
    return correct;
  }
}
