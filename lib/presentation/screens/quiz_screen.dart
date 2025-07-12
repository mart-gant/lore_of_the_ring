
import 'package:flutter/material.dart';
import '../../../data/datasources/question_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuestionService _questionService = QuestionService();
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _correctAnswers = 0;
  int? _selectedIndex;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await _questionService.fetchQuestions();
    setState(() => _questions = questions);
  }

  void _submitAnswer() {
    if (_selectedIndex == _questions[_currentIndex].correctIndex) {
      _correctAnswers++;
    }
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
      });
    } else {
      setState(() => _isFinished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_isFinished) {
      return Scaffold(
        appBar: AppBar(title: const Text('Wynik')),
        body: Center(
          child: Text('Twój wynik: $_correctAnswers / ${_questions.length}'),
        ),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pytanie ${_currentIndex + 1}/${_questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
            ),
            const SizedBox(height: 16),
            Text(
              question.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Kategoria: ${question.category} | Trudność: ${question.difficulty}'),
            const SizedBox(height: 12),
            ...List.generate(question.options.length, (i) {
              return RadioListTile<int>(
                title: Text(question.options[i]),
                value: i,
                groupValue: _selectedIndex,
                onChanged: (value) => setState(() => _selectedIndex = value),
              );
            }),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _selectedIndex == null ? null : _submitAnswer,
              child: const Text('Dalej'),
            ),
          ],
        ),
      ),
    );
  }
}
