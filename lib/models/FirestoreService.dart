import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Quiz.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveQuizToFB(Quiz quiz) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // throw error
      }

      final userCollection =
          _db.collection('users').doc(user!.uid).collection('questions');

      await userCollection.add(quiz.quizToMap());
    } catch (e) {}
  }

  // Future<void> saveQuestion(
  //     String id, Map<String, dynamic> question_map) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;

  //     if (user == null) {
  //       // throw error
  //     }

  //     final userCollection =
  //         _db.collection('users').doc(user!.uid).collection('questions');

  //     await userCollection.add(question_map);
  //   } catch (e) {
  //     print("Error saving data: $e");
  //   }
  // }
}
