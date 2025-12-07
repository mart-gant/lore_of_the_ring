
import 'package:lore_of_the_ring/data/datasources/answer_service.dart';
import 'package:lore_of_the_ring/domain/repositories/answer_repository.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  final AnswerService answerService;

  AnswerRepositoryImpl(this.answerService);

  @override
  Future<void> submitAnswer({
    required String questionId,
    required int selectedIndex,
    required bool isCorrect,
  }) {
    return answerService.saveAnswer(
      questionId: questionId,
      selectedIndex: selectedIndex,
      isCorrect: isCorrect,
    );
  }
}
