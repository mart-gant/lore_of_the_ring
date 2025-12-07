
import 'package:flutter/material.dart';
import 'package:lore_of_the_ring/data/datasources/score_service.dart';
import 'package:lore_of_the_ring/domain/models/question.dart';
import 'package:lore_of_the_ring/domain/usecases/get_questions_usecase.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/auth_viewmodel.dart';

class QuizViewModel extends ChangeNotifier {
  final GetQuestionsUseCase _getQuestionsUseCase;
  final ScoreService _scoreService;
  final AuthViewModel _authViewModel; // To get the user ID

  QuizViewModel(
      this._getQuestionsUseCase, this._scoreService, this._authViewModel) {
    _loadQuestions();
  }

  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizFinished = false;
  bool get isLoading => _questions.isEmpty && !_quizFinished;

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get quizFinished => _quizFinished;

  Future<void> _loadQuestions() async {
    // Reset state before loading new questions
    _questions = [];
    _currentQuestionIndex = 0;
    _score = 0;
    _quizFinished = false;
    // Notify listeners to show a loading indicator
    notifyListeners();

    _questions = await _getQuestionsUseCase();
    notifyListeners();
  }

  void submitAnswer(String answer) {
    if (_quizFinished) return;

    if (_questions[_currentQuestionIndex].correctAnswer == answer) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _quizFinished = true;
      _saveCurrentScore();
    }

    notifyListeners();
  }

  Future<void> _saveCurrentScore() async {
    if (_authViewModel.isLoggedIn) {
      await _scoreService.saveScore(_score, _authViewModel.user!.uid);
    }
  }

  void resetQuiz() {
    _loadQuestions();
  }
}
