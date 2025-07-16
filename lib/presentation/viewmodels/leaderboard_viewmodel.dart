import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardEntry {
  final String username;
  final int correctAnswers;

  LeaderboardEntry({
    required this.username,
    required this.correctAnswers,
  });

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
      username: map['username'] ?? 'Nieznany',
      correctAnswers: map['correct_answers'] ?? 0,
    );
  }
}

class LeaderboardViewModel extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  List<LeaderboardEntry> _entries = [];
  List<LeaderboardEntry> get entries => _entries;

  Future<void> loadLeaderboard() async {
    // Wywołanie RPC bez select()
    final data = await client.rpc('get_leaderboard');

    // Rzutowanie
    final list = (data as List<dynamic>).cast<Map<String, dynamic>>();

    _entries = list
        .map((item) => LeaderboardEntry.fromMap(item))
        .toList();

    notifyListeners();
  }
}
