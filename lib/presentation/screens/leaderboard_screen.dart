
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lore_of_the_ring/presentation/viewmodels/leaderboard_viewmodel.dart';
import 'package:lore_of_the_ring/presentation/theme/app_theme.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LeaderboardViewModel>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: viewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gondorGold),
                ),
              )
            : RefreshIndicator(
                onRefresh: () => viewModel.fetchLeaderboard(),
                child: ListView.builder(
                  itemCount: viewModel.scores.length,
                  itemBuilder: (context, index) {
                    final score = viewModel.scores[index];
                    return ListTile(
                      leading: Text(
                        '${index + 1}.',
                        style: textTheme.titleLarge?.copyWith(color: AppTheme.gondorGold),
                      ),
                      title: Text(
                        'Użytkownik (ID: ${score.userId.substring(0, 8)}...)',
                         style: textTheme.titleMedium?.copyWith(color: AppTheme.parchment),
                      ),
                      trailing: Text(
                        '${score.score} pkt',
                         style: textTheme.titleLarge?.copyWith(color: AppTheme.gondorGold),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
