
import 'package:lore_of_the_ring/data/datasources/question_service.dart';
import 'package:lore_of_the_ring/domain/models/question.dart';
import 'package:lore_of_the_ring/domain/repositories/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionService questionService;

  QuestionRepositoryImpl(this.questionService);

  @override
  Future<List<Question>> getQuestions() {
    return questionService.getQuestions();
  }
}
