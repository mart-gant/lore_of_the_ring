abstract class AnswerRepository {
  Future<void> submitAnswer({
    required String questionId,
    required int selectedIndex,
    required bool isCorrect,
  });
}
