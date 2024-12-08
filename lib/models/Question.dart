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
  double studentGrade = 0;

  bool? tfCorrectAnswer;
  bool? tfSelectedAnswer;

  String? mcqCorrectAnswer;
  String? mcqSelectedAnswer;

  String? writtenCorrectAnswer;
  String? writtenSelectedAnswer;

  /// Convert Question to Map
  Map<String, dynamic> questionToMap() {
    return {
      "questionID": questionID,
      "quizId": quizId,
      "question_type": question_type,
      "question_text": question_text,
      // mcq
      "possibleMcqAnswers": possibleMcqAnswers,
      "mcqCorrectAnswer": mcqCorrectAnswer,
      "mcqSelectedAnswer": mcqSelectedAnswer,
      // tf
      "tfCorrectAnswer": tfCorrectAnswer,
      "tfSelectedAnswer": tfSelectedAnswer,
      // wriiten
      "writtenCorrectAnswer": writtenCorrectAnswer,
      "writtenSelectedAnswer": writtenSelectedAnswer
    };
  }

  /// Convert Map to Question
  fromMap(Map<String, dynamic> data) {
    questionID = data['questionID'] ?? '';
    quizId = data['quizId'] ?? '';
    question_type = data['question_type'] ?? '';
    question_text = data['question_text'] ?? '';
    // MCQ
    possibleMcqAnswers = List<String>.from(data['possibleMcqAnswers'] ?? []);
    mcqCorrectAnswer = data['mcqCorrectAnswer'];
    mcqSelectedAnswer = data['mcqSelectedAnswer'];
    // True/False
    tfCorrectAnswer = data['tfCorrectAnswer'];
    tfSelectedAnswer = data['tfSelectedAnswer'];
    // Written
    writtenCorrectAnswer = data['writtenCorrectAnswer'];
    writtenSelectedAnswer = data['writtenSelectedAnswer'];
  }

  gradeQuestionAnswer() {
    switch (question_type) {
      case "MCQ":
        if (mcqSelectedAnswer != null &&
            mcqCorrectAnswer != null &&
            mcqSelectedAnswer == mcqCorrectAnswer) {
          studentGrade = questionGrade;
        } else {
          studentGrade = 0;
        }
        break;
      case "TF":
        if (tfSelectedAnswer != null &&
            tfCorrectAnswer != null &&
            tfSelectedAnswer == tfCorrectAnswer) {
          studentGrade = questionGrade;
        } else {
          studentGrade = 0;
        }

      case "WRITTEN":
        studentGrade = 0;
        break;
    }
  }

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  /// Save Question to Firestore
  Future<void> saveToDB(CollectionReference questionCollection) async {
    final docRef = questionID.isEmpty
        ? await questionCollection.add(questionToMap())
        : questionCollection.doc(questionID);

    if (questionID.isEmpty) {
      questionID = docRef.id; // Assign generated Firestore ID
    } else {
      await docRef.set(questionToMap());
    }
  }

  /// Convert Question to a Solvable Widget
  Widget toWidget() {
    switch (question_type) {
      case "MCQ":
        return MCQWidget(
          questionText: question_text,
          possibleAnswers: possibleMcqAnswers,
          selectedAnswer: mcqSelectedAnswer ?? '',
          onAnswerSelected: (value) {
            mcqSelectedAnswer = value;
          },
        );
      case "TF":
        return TrueFalseWidget(
          questionText: question_text,
          selectedValue: tfSelectedAnswer,
          onValueSelected: (value) {
            tfSelectedAnswer = value;
          },
        );
      case "WRITTEN":
        return WrittenWidget(
          questionText: question_text,
          initialAnswer: writtenCorrectAnswer,
          onAnswerChanged: (value) {
            writtenCorrectAnswer = value;
          },
        );
      default:
        return Text("Unsupported question type: $question_type");
    }
  }

  static List<Map<dynamic, dynamic>> allQuestionTypes = [
    {"title": 'True/False', "value": "TF"},
    {"title": 'MCQ', "value": "MCQ"},
    {"title": "WRITTEN", "value": 'WRITTEN'}
  ];

  static List<Map<dynamic, dynamic>> trueFalseValues = [
    {"title": 'True', "value": true},
    {"title": 'False', "value": false},
  ];
}
