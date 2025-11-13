
import 'package:flutter/foundation.dart';

@immutable
class Score {
  final String id;
  final String userId;
  final int score;
  final DateTime createdAt;

  const Score({
    required this.id,
    required this.userId,
    required this.score,
    required this.createdAt,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      score: json['score'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
