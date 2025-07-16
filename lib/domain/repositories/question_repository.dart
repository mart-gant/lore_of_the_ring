import '../models/question.dart';

abstract class QuestionRepository {
  Future<List<Question>> getQuestions();
}
