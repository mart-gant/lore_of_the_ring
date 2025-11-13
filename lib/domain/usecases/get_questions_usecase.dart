
import 'package:lore_of_the_ring/domain/models/question.dart';
import 'package:lore_of_the_ring/domain/repositories/question_repository.dart';

class GetQuestionsUseCase {
  final QuestionRepository repository;

  GetQuestionsUseCase(this.repository);

  Future<List<Question>> call() {
    return repository.getQuestions();
  }
}
