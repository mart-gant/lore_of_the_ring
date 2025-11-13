
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lore_of_the_ring/data/datasources/question_service.dart';
import 'package:lore_of_the_ring/data/repositories/question_repository_impl.dart';
import 'package:lore_of_the_ring/domain/repositories/question_repository.dart';
import 'package:lore_of_the_ring/domain/usecases/get_questions_usecase.dart';
import 'package:lore_of_the_ring/presentation/screens/splash_screen.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/quiz_viewmodel.dart';
import 'package:lore_of_the_ring/services/supabase_service.dart';
import 'package:lore_of_the_ring/presentation/theme/app_theme.dart';
import 'package:lore_of_the_ring/services/auth_service.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/auth_viewmodel.dart';
import 'package:lore_of_the_ring/data/datasources/score_service.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/leaderboard_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<SupabaseService>(
          create: (_) => SupabaseService(),
        ),
        Provider<QuestionService>(
          create: (context) => QuestionService(context.read<SupabaseService>()),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<ScoreService>(
          create: (_) => ScoreService(),
        ),
        
        // Repositories
        Provider<QuestionRepository>(
          create: (context) => QuestionRepositoryImpl(context.read<QuestionService>()),
        ),
        
        // Use Cases
        Provider<GetQuestionsUseCase>(
          create: (context) => GetQuestionsUseCase(context.read<QuestionRepository>()),
        ),

        // View Models
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(context.read<AuthService>()),
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
