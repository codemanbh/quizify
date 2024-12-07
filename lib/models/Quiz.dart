import './Question.dart';

class Quiz {
  String id = "";
  String title = "";
  String description = "";
  DateTime? start_date;
  DateTime? end_date;
  List<Question> questions = [];

  Map<String, dynamic> quizToMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      'start_date': start_date?.toIso8601String(),
      'end_date': end_date?.toIso8601String(),
      'questions':
          questions.map((question) => question.questionToMap()).toList(),
    };
  }
}
