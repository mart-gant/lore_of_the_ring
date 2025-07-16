import '../repositories/answer_repository.dart';

class SubmitAnswerUseCase {
  final AnswerRepository repository;

  SubmitAnswerUseCase(this.repository);

  Future<void> call({
    required String questionId,
    required int selectedIndex,
    required bool isCorrect,
  }) {
    return repository.submitAnswer(
      questionId: questionId,
      selectedIndex: selectedIndex,
      isCorrect: isCorrect,
    );
  }
}
