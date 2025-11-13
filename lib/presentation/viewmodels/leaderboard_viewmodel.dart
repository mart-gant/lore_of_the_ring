
import 'package:flutter/material.dart';
import 'package:lore_of_the_ring/domain/entities/score.dart';
import 'package:lore_of_the_ring/data/datasources/score_service.dart';

class LeaderboardViewModel extends ChangeNotifier {
  final ScoreService _scoreService;

  LeaderboardViewModel(this._scoreService) {
    fetchLeaderboard();
  }

  List<Score> _scores = [];
  bool _isLoading = false;

  List<Score> get scores => _scores;
  bool get isLoading => _isLoading;

  Future<void> fetchLeaderboard() async {
    _isLoading = true;
    notifyListeners();

    _scores = await _scoreService.getLeaderboard();

    _isLoading = false;
    notifyListeners();
  }
}
