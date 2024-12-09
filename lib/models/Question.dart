import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/buildQuiz/MCQWidget.dart';
import '../components/buildQuiz/TrueFalseWidget.dart';
import '../components/buildQuiz/WrittenWidget.dart';
// import '../models/Quiz.dart';

class Question {
  String questionID = '';
  String quizId = '';
  String question_type = "";
  String question_text = "";

  List<String> possibleMcqAnswers = [];

  double questionGrade = 0;
  double? studentGrade;

  String? teacherCorrectAnswer;
  String? studentSelectedAnswer;

  static List<Map<dynamic, dynamic>> allQuestionTypes = [
    {"title": 'True/False', "value": "TF"},
    {"title": 'MCQ', "value": "MCQ"},
    {"title": "WRITTEN", "value": 'WRITTEN'}
  ];

  static List<Map<dynamic, dynamic>> trueFalseValues = [
    {"title": 'True', "value": 'true'},
    {"title": 'False', "value": 'false'},
  ];

  Question();
  // Constructor to initialize Question from a Map
  Question.questionFromMap(Map<String, dynamic> data)
      : questionID = data['questionID'] ?? '',
        quizId = data['quizId'] ?? '',
        question_type = data['question_type'] ?? '',
        question_text = data['question_text'] ?? '',
        possibleMcqAnswers =
            List<String>.from(data['possibleMcqAnswers'] ?? []),
        teacherCorrectAnswer = data['teacherCorrectAnswer'],
        studentSelectedAnswer = data['studentSelectedAnswer'];

  get text => null;

  /// Convert Question to Map
  Map<String, dynamic> questionToMap() {
    return {
      "questionID": questionID,
      "quizId": quizId,
      "question_type": question_type,
      "question_text": question_text,
      "questionGrade": questionGrade,
      "studentGrade": studentGrade,
      "possibleMcqAnswers": possibleMcqAnswers,
      "teacherCorrectAnswer": teacherCorrectAnswer,
      "studentSelectedAnswer": studentSelectedAnswer,
    };
  }

  gradeQuestionAnswer() {
    if (question_type != 'WRITTEN') {
      if (teacherCorrectAnswer != null &&
          teacherCorrectAnswer == studentSelectedAnswer) {
        studentGrade = questionGrade;
      } else {
        studentGrade = 0;
      }
    } else {
      studentGrade = null;
    }
  }

  /// Convert Question to a Solvable Widget
  Widget questionToWidget() {
    switch (question_type) {
      case "MCQ":
        return MCQWidget(
          questionText: question_text,
          possibleAnswers: possibleMcqAnswers,
          selectedAnswer: studentSelectedAnswer ?? '',
          onAnswerSelected: (value) {
            studentSelectedAnswer = value;
          },
        );
      case "TF":
        return TrueFalseWidget(
          questionText: question_text,
          selectedValue: teacherCorrectAnswer,
          onValueSelected: (value) {
            teacherCorrectAnswer = value;
          },
        );
      case "WRITTEN":
        return WrittenWidget(
          questionText: question_text,
          initialAnswer: teacherCorrectAnswer,
          onAnswerChanged: (value) {
            teacherCorrectAnswer = value;
          },
        );
      default:
        return Text("Unsupported question type: $question_type");
    }
  }
}
