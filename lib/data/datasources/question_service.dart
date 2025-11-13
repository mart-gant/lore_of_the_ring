
import 'package:lore_of_the_ring/domain/models/question.dart';
import 'package:lore_of_the_ring/services/supabase_service.dart';

class QuestionService {
  final SupabaseService _supabaseService;

  QuestionService(this._supabaseService);

  Future<List<Question>> getQuestions() async {
    try {
      final response = await _supabaseService.client.from('questions').select();

      if (response.isEmpty) {
        return [];
      }
      
      final questions = response.map((json) => Question.fromJson(json)).toList();
      return questions;
    } catch (e) {
      // You might want to handle errors more gracefully
      print('Error fetching questions: $e');
      return [];
    }
  }
}
