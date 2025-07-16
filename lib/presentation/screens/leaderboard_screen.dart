import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/leaderboard_viewmodel.dart';


class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      await context.read<LeaderboardViewModel>().loadLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final entries = context.watch<LeaderboardViewModel>().entries;

    return Scaffold(
      appBar: AppBar(title: const Text('Ranking')),
      body: entries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
        itemCount: entries.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final entry = entries[index];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(entry.username),
            trailing: Text('${entry.correctAnswers} pkt'),
          );
        },
      ),
    );
  }
}
