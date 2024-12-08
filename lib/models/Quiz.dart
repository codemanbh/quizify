import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import './Question.dart';

class Quiz {
  String id = "";
  String title = "";
  String description = "";
  DateTime? start_date;
  DateTime? end_date;
  List<Question> questions = [];

  /// Save the Quiz to Firestore
  Future<void> saveToDB() async {
    final quizCollection = FirebaseFirestore.instance.collection('quizzes');
    final questionCollection =
        FirebaseFirestore.instance.collection('questions');

    // Save quiz
    final docRef = id.isEmpty
        ? await quizCollection.add(quizToMap())
        : quizCollection.doc(id);
    if (id.isEmpty) {
      id = docRef.id; // Assign generated Firestore ID
    } else {
      await docRef.set(quizToMap());
    }

    // Save associated questions
    for (var question in questions) {
      question.quizId = id; // Ensure question has the quiz ID
      await question.saveToDB(questionCollection);
    }
  }

  /// Retrieve Quiz and its Questions from Firestore
  static Future<Quiz> retrieveFromDB(String quizId) async {
    final quizCollection = FirebaseFirestore.instance.collection('quizzes');
    final questionCollection =
        FirebaseFirestore.instance.collection('questions');

    // Retrieve quiz
    final quizSnapshot = await quizCollection.doc(quizId).get();
    if (!quizSnapshot.exists) {
      throw Exception("Quiz with ID $quizId not found.");
    }

    final quizData = quizSnapshot.data()!;
    Quiz quiz = Quiz.fromMap(quizData);
    quiz.id = quizId;

    // Retrieve associated questions
    final questionSnapshot =
        await questionCollection.where('quizId', isEqualTo: quizId).get();
    quiz.questions = questionSnapshot.docs
        .map((doc) => Question.fromMap(doc.data()))
        .toList();

    return quiz;
  }

  /// Convert Quiz to Map
  Map<String, dynamic> quizToMap() {
    return {
      "title": title,
      "description": description,
      'start_date': start_date?.toIso8601String(),
      'end_date': end_date?.toIso8601String(),
    };
  }

  /// Convert Map to Quiz
  static Quiz fromMap(Map<String, dynamic> data) {
    return Quiz()
      ..title = data['title'] ?? ''
      ..description = data['description'] ?? ''
      ..start_date =
          data['start_date'] != null ? DateTime.parse(data['start_date']) : null
      ..end_date =
          data['end_date'] != null ? DateTime.parse(data['end_date']) : null;
  }
}
