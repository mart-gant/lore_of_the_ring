
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/auth_viewmodel.dart';
import 'package:lore_of_the_ring/presentation/screens/login_screen.dart';
import 'package:lore_of_the_ring/presentation/screens/quiz_screen.dart';
import 'package:lore_of_the_ring/presentation/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for a bit
    await Future.delayed(const Duration(seconds: 2));

    // Check if the widget is still in the tree.
    if (!mounted) return;

    final authViewModel = context.read<AuthViewModel>();

    if (authViewModel.isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const QuizScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gondorGold),
          ),
        ),
      ),
    );
  }
}
