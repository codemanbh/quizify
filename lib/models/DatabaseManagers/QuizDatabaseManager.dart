import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Quiz.dart';

class QuizDatabaseManager {
  final CollectionReference quizzesCollection =
      FirebaseFirestore.instance.collection('quizzes');

  Future<void> deleteQuiz(Quiz quiz) async {
    quizzesCollection.doc(quiz.quizID).delete();
  }

  /// Adds a quiz to the Firebase database without specifying an ID
  Future<void> addQuiz(Quiz quiz) async {
    Map<String, dynamic> quizMap = quiz.quizToMap();
    DocumentReference docRef;
    try {
      // Convert the quiz to a map
      if (quiz.quizID == null || quiz.quizID == '') {
        docRef = await quizzesCollection.add(quizMap);
      } else {
        docRef = await quizzesCollection.doc(quiz.quizID);
        await docRef.set(quizMap);
      }
      // Add the quiz to Firestore, letting Firestore generate the document ID

      // print("Quiz added successfully with ID: ${docRef.id}");
    } catch (e) {
      print("Failed to add quiz: $e");
      throw e; // Re-throw the exception for error handling
    }
  }

  /// Fetch a quiz from the Firebase database by ID
  Future<Quiz?> getQuiz(String quizID) async {
    try {
      DocumentSnapshot doc = await quizzesCollection.doc(quizID).get();

      if (doc.exists) {
        // Convert the document data to a Quiz object
        return Quiz.quizFromMap(doc.data() as Map<String, dynamic>);
      } else {
        print("Quiz with ID $quizID does not exist.");
        return null;
      }
    } catch (e) {
      print("Failed to fetch quiz: $e");
      throw e;
    }
  }

  /// Delete a quiz from the Firebase database by ID
  // Future<void> deleteQuiz(String quizID) async {
  //   try {
  //     await quizzesCollection.doc(quizID).delete();
  //     print("Quiz deleted successfully!");
  //   } catch (e) {
  //     print("Failed to delete quiz: $e");
  //     throw e;
  //   }
  // }
}
  // Future<void> saveResultsToDB() async {
  //   // Get the answers map
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   User? user = _auth.currentUser;

  //   final answersMap = getAnswersMap(user!.uid);

  //   // Reference to the Firestore collection where results will be saved
  //   CollectionReference resultsCollection =
  //       FirebaseFirestore.instance.collection('quiz_results');

  //   try {
  //     // Add the student results to Firestore
  //     await resultsCollection.add(answersMap);

  //     // Optionally, print or log the success
  //     print("Student results saved successfully.");
  //   } catch (e) {
  //     // Handle any errors that occur during the save
  //     print("Error saving student results: $e");
  //   }
  // }

  // /// Save Question to Firestore
  // Future<void> saveQuestionToDB(CollectionReference questionCollection) async {
  //   final docRef = questionID.isEmpty
  //       ? await questionCollection.add(questionToMap())
  //       : questionCollection.doc(questionID);

  //   if (questionID.isEmpty) {
  //     questionID = docRef.id; // Assign generated Firestore ID
  //   } else {
  //     await docRef.set(questionToMap());
  //   }
  // }



  // Future<void> saveResultsToDB() async {
  //   // Get the answers map
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   User? user = _auth.currentUser;

  //   final answersMap = getAnswersMap(user!.uid);

  //   // Reference to the Firestore collection where results will be saved
  //   CollectionReference resultsCollection =
  //       FirebaseFirestore.instance.collection('quiz_results');

  //   try {
  //     // Add the student results to Firestore
  //     await resultsCollection.add(answersMap);

  //     // Optionally, print or log the success
  //     print("Student results saved successfully.");
  //   } catch (e) {
  //     // Handle any errors that occur during the save
  //     print("Error saving student results: $e");
  //   }
  // }