class Question {
  final String text;
  final List<String> answers;
  final String correctAnswer;

  Question({
    required this.text,
    required this.answers,
    required this.correctAnswer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'] as String,
      answers: List<String>.from(map['answers']),
      correctAnswer: map['correct_answer'] as String,
    );
  }
}
