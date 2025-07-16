import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/question.dart';
import '../../domain/repositories/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final SupabaseClient client = Supabase.instance.client;

  @override
  Future<List<Question>> getQuestions() async {
    final response = await client.from('questions').select();
    final data = List<Map<String, dynamic>>.from(response);
    return data.map((item) => Question.fromMap(item)).toList();
  }
}
