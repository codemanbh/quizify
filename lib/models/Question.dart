import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question {
  String id = '';
  String quizId = ''; // Reference to the Quiz ID
  String question_type = "";
  String question_text = "";
  List<String> possible_answers = [];
  List<String> correct_answer = [];
  double grade = 0;
  bool isRequired = false;

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
        return _buildMCQWidget();
      case "TF":
        return _buildTrueFalseWidget();
      case "WRITTEN":
        return _buildWrittenWidget();
      default:
        return Text("Unsupported question type: $question_type");
    }
  }

  /// Build MCQ Widget
  Widget _buildMCQWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question_text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        for (var answer in possible_answers)
          RadioListTile<String>(
            title: Text(answer),
            value: answer,
            groupValue: correct_answer.isNotEmpty ? correct_answer.first : null,
            onChanged: (value) {
              if (value != null) {
                correct_answer = [value]; // Only one answer allowed for MCQ
              }
            },
          ),
      ],
    );
  }

  /// Convert Map to Question
  static Question fromMap(Map<String, dynamic> data) {
    return Question()
      ..quizId = data['quizId'] ?? ''
      ..question_type = data['question_type'] ?? ''
      ..question_text = data['question_text'] ?? ''
      ..possible_answers = List<String>.from(data['possible_answers'] ?? [])
      ..correct_answer = List<String>.from(data['correct_answer'] ?? [])
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

  /// Build True/False Widget
  Widget _buildTrueFalseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question_text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        for (var option in trueFalseValues)
          RadioListTile<bool>(
            title: Text(option["title"]),
            value: option["value"],
            groupValue: correct_answer.contains("True"),
            onChanged: (value) {
              if (value != null) {
                correct_answer = [value ? "True" : "False"];
              }
            },
          ),
      ],
    );
  }

  /// Build Written Response Widget
  Widget _buildWrittenWidget() {
    TextEditingController controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question_text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Write your answer here",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            correct_answer = [value]; // Store written response as the answer
          },
        ),
      ],
    );
  }
}
