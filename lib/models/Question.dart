import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/buildQuiz/MCQWidget.dart';
import '../components/buildQuiz/TrueFalseWidget.dart';
import '../components/buildQuiz/WrittenWidget.dart';

class Question {
  String id = '';
  String quizId = ''; // Reference to the Quiz ID
  String question_type = "";
  String question_text = "";
  List<String> possible_answers = [];
  String? correct_answer = null;
  double grade = 0;
  bool isRequired = false;
  bool? tfSelectedAnswer;
  String? writtenAnswer;
  int? mcqSelectedAnswer;

  dynamic getSelectedAnswer() {
    switch (question_type) {
      case "MCQ":
        return mcqSelectedAnswer != null
            ? possible_answers[mcqSelectedAnswer!]
            : null;
      case "TF":
        return tfSelectedAnswer;
      case "WRITTEN":
        return correct_answer;
      default:
        return null; // Unsupported question type
    }
  }

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  Map<String, dynamic> getSelectedMap() {
    // print("questionid: ${id}");
    Map<String, dynamic> selectedMap = {
      "questionID": id,
      "question_type": question_type,
      "correct_answer": correct_answer,
    };

    // Assign grade based on the selected answer
    double selectedGrade = 0;
    switch (question_type) {
      case "MCQ":
        if (mcqSelectedAnswer != null) {
          selectedMap["selected_answer_mcq"] =
              possible_answers[mcqSelectedAnswer!];
          // Check if the selected answer is correct
          if (possible_answers[mcqSelectedAnswer!] == correct_answer) {
            selectedGrade = grade; // Full grade if correct
          }
        }
        break;
      case "TF":
        print("correct_answer[0]: ${correct_answer.runtimeType}");
        selectedMap["selected_answer_tf"] = tfSelectedAnswer;
        // Check if the selected answer is correct

        if (equalsIgnoreCase(correct_answer, tfSelectedAnswer.toString())) {
          selectedGrade = grade; // Full grade if correct
        }
        break;
      case "WRITTEN":
        selectedMap["selected_answer_written"] = writtenAnswer;
        // No grade assigned for WRITTEN type questions
        break;
      default:
        selectedMap["selected_answer"] = null; // Handle unsupported types
    }

    // Add the grade to the map only for MCQ and TF questions
    if (question_type == "MCQ" || question_type == "TF") {
      selectedMap["grade"] = selectedGrade;
    }

    return selectedMap;
  }

  /// Save Question to Firestore
  Future<void> saveToDB(CollectionReference questionCollection) async {
    final docRef = id.isEmpty
        ? await questionCollection.add(questionToMap())
        : questionCollection.doc(id);

    if (id.isEmpty) {
      id = docRef.id; // Assign generated Firestore ID
    } else {
      await docRef.set(questionToMap());
    }
  }

  /// Convert Question to Map
  Map<String, dynamic> questionToMap() {
    return {
      "quizId": quizId,
      "question_type": question_type,
      "question_text": question_text,
      "possible_answers": possible_answers,
      "correct_answer": correct_answer,
      "grade": grade,
      "isRequired": isRequired,
    };
  }

  /// Convert Question to a Solvable Widget
  Widget toWidget() {
    switch (question_type) {
      case "MCQ":
        return MCQWidget(
          questionText: question_text,
          possibleAnswers: possible_answers,
          selectedAnswer: mcqSelectedAnswer,
          onAnswerSelected: (value) {
            mcqSelectedAnswer = value;
          },
        );
      case "TF":
        return TrueFalseWidget(
          questionText: question_text,
          selectedValue: tfSelectedAnswer == 'True',
          onValueSelected: (value) {
            tfSelectedAnswer = value;
          },
        );
      case "WRITTEN":
        return WrittenWidget(
          questionText: question_text,
          initialAnswer: correct_answer,
          onAnswerChanged: (value) {
            correct_answer = value;
          },
        );
      default:
        return Text("Unsupported question type: $question_type");
    }
  }

  /// Convert Map to Question
  static Question fromMap(Map<String, dynamic> data) {
    // print(data);
    return Question()
      ..quizId = data['quizId'] ?? ''
      ..question_type = data['question_type'] ?? ''
      ..question_text = data['question_text'] ?? ''
      ..possible_answers = List<String>.from(data['possible_answers'] ?? [])
      ..correct_answer = data['correct_answer']
      ..grade = (data['grade'] ?? 0).toDouble()
      ..isRequired = data['isRequired'] ?? false;
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
