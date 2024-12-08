import 'package:quizify/models/Question.dart';

import '../models/Quiz.dart';

class StudentAnswer {
  String studentID = "";
  String quizID = "";
  List<Map<String, dynamic>> StudentAnswers = [];

  saveAnswers(String newStudentID, Quiz quiz) {
    studentID = newStudentID;
    quizID = quiz.id;
    StudentAnswers =
        quiz.questions.map((question) => question.getSelectedMap()).toList();
  }
}
