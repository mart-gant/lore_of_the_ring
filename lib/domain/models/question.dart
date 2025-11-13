
class Question {
  final int id;
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['question_text'],
      options: (json['options'] as List).map((item) => item as String).toList(),
      correctAnswer: json['correct_answer'],
    );
  }
}
