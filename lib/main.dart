
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lore_of_the_ring/data/datasources/question_service.dart';
import 'package:lore_of_the_ring/data/repositories/question_repository_impl.dart';
import 'package:lore_of_the_ring/domain/repositories/question_repository.dart';
import 'package:lore_of_the_ring/domain/usecases/get_questions_usecase.dart';
import 'package:lore_of_the_ring/presentation/screens/splash_screen.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/quiz_viewmodel.dart';
import 'package:lore_of_the_ring/presentation/theme/app_theme.dart';
import 'package:lore_of_the_ring/services/firebase_auth_service.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/auth_viewmodel.dart';
import 'package:lore_of_the_ring/data/datasources/score_service.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/leaderboard_viewmodel.dart';
import 'package:lore_of_the_ring/data/datasources/answer_service.dart';
import 'package:lore_of_the_ring/data/repositories/answer_repository_impl.dart';
import 'package:lore_of_the_ring/domain/repositories/answer_repository.dart';
import 'package:lore_of_the_ring/domain/usecases/submit_answer_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<QuestionService>(
          create: (_) => QuestionService(),
        ),
        Provider<ScoreService>(
          create: (_) => ScoreService(),
        ),
        Provider<AnswerService>(
          create: (_) => AnswerService(),
        ),
        Provider<QuestionRepository>(
          create: (context) => QuestionRepositoryImpl(context.read<QuestionService>()),
        ),
        Provider<AnswerRepository>(
          create: (context) => AnswerRepositoryImpl(context.read<AnswerService>()),
        ),
        Provider<GetQuestionsUseCase>(
          create: (context) => GetQuestionsUseCase(context.read<QuestionRepository>()),
        ),
        Provider<SubmitAnswerUseCase>(
          create: (context) => SubmitAnswerUseCase(context.read<AnswerRepository>()),
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(context.read<FirebaseAuthService>()),
        ),
        ChangeNotifierProvider<QuizViewModel>(
          create: (context) => QuizViewModel(
            context.read<GetQuestionsUseCase>(),
            context.read<ScoreService>(),
            context.read<AuthViewModel>(),
          ),
        ),
        ChangeNotifierProvider<LeaderboardViewModel>(
          create: (context) => LeaderboardViewModel(context.read<ScoreService>()),
        ),
      ],
      child: MaterialApp(
        title: 'Lore of the Ring',
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}
