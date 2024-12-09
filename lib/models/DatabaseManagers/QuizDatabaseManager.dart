import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizDatabaseManager {
  Future<void> saveResultsToDB() async {
    // Get the answers map
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    final answersMap = getAnswersMap(user!.uid);

    // Reference to the Firestore collection where results will be saved
    CollectionReference resultsCollection =
        FirebaseFirestore.instance.collection('quiz_results');

    try {
      // Add the student results to Firestore
      await resultsCollection.add(answersMap);

      // Optionally, print or log the success
      print("Student results saved successfully.");
    } catch (e) {
      // Handle any errors that occur during the save
      print("Error saving student results: $e");
    }
  }

  /// Save Question to Firestore
  Future<void> saveQuestionToDB(CollectionReference questionCollection) async {
    final docRef = questionID.isEmpty
        ? await questionCollection.add(questionToMap())
        : questionCollection.doc(questionID);

    if (questionID.isEmpty) {
      questionID = docRef.id; // Assign generated Firestore ID
    } else {
      await docRef.set(questionToMap());
    }
  }
}
