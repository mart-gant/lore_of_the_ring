
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/auth_viewmodel.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/quiz_viewmodel.dart';
import 'package:lore_of_the_ring/presentation/theme/app_theme.dart';
import 'package:lore_of_the_ring/presentation/screens/leaderboard_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizViewModel = context.watch<QuizViewModel>();
    final authViewModel = context.read<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authViewModel.signOut(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildQuizContent(context, quizViewModel),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizContent(BuildContext context, QuizViewModel viewModel) {
    if (viewModel.quizFinished) {
      return _buildResultScreen(context, viewModel);
    }

    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gondorGold),
        ),
      );
    }

    return _buildQuestionScreen(context, viewModel);
  }

  Widget _buildResultScreen(BuildContext context, QuizViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ukończyłeś Quiz!',
            style: textTheme.headlineMedium?.copyWith(color: AppTheme.darkWood),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Twój wynik: ${viewModel.score} / ${viewModel.questions.length}',
            style: textTheme.titleLarge?.copyWith(color: AppTheme.darkWood),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => viewModel.resetQuiz(),
            child: const Text('Zagraj Ponownie'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
              );
            },
            child: const Text('Zobacz Ranking'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionScreen(BuildContext context, QuizViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final question = viewModel.questions[viewModel.currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pytanie ${viewModel.currentQuestionIndex + 1}/${viewModel.questions.length}',
          style: textTheme.titleMedium?.copyWith(color: AppTheme.gondorGold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppTheme.parchment.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.darkWood.withOpacity(0.5)),
          ),
          child: Text(
            question.questionText,
            style: textTheme.headlineSmall?.copyWith(color: AppTheme.darkWood),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        ...question.options.map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () => viewModel.submitAnswer(option),
              child: Text(option),
            ),
          );
        }).toList(),
      ],
    );
  }
}
