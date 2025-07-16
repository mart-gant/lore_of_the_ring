import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/quiz_viewmodel.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizViewModel _quizVM;
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _quizVM = context.read<QuizViewModel>();
    _quizVM.loadNextQuestion();
  }

  Future<void> _submitAnswer() async {
    if (_selectedAnswer == null) return;

    final isCorrect = await _quizVM.submitAnswer(_selectedAnswer!);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Dobrze!' : 'Źle!'),
        duration: const Duration(seconds: 1),
      ),
    );

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    _quizVM.loadNextQuestion();
    setState(() => _selectedAnswer = null);
  }

  @override
  Widget build(BuildContext context) {
    final question = _quizVM.currentQuestion;

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question!.text, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            ...question.answers.map((answer) => RadioListTile<String>(
              title: Text(answer),
              value: answer,
              groupValue: _selectedAnswer,
              onChanged: (value) => setState(() => _selectedAnswer = value),
            )),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _submitAnswer, child: const Text('Zatwierdź')),
          ],
        ),
      ),
    );
  }
}
