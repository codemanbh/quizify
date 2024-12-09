import './Question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './DatabaseManagers/QuizDatabaseManager.dart';

class Quiz {
  String quizID = "";
  String teacherID = "";
  String studentID = "";
  String quizMode = "creation";
  String title = "";
  String description = "";
  DateTime? start_date;
  DateTime? end_date;
  List<Question> questions = [];

  static List<String> quizModes = ['creation', 'attempt'];

  void saveQuizToDB() {
    QuizDatabaseManager qdm = QuizDatabaseManager();
    qdm.addQuiz(this);
  }

  Future<void> deleteQuiz() async {
    QuizDatabaseManager qdm = QuizDatabaseManager();
    qdm.deleteQuiz(this);
  }

  void gradeAnswers() {
    quizMode = 'attempt';

    for (int i = 0; i < questions.length; i++) {
      questions[i].gradeQuestionAnswer();
    }
  }

  // Convert Quiz to Map
  Map<String, dynamic> quizToMap() {
    return {
      'quizID': quizID,
      'teacherID': teacherID,
      'studentID': studentID,
      'quizMode': quizMode,
      'title': title,
      'description': description,
      'start_date': start_date?.toIso8601String(),
      'end_date': end_date?.toIso8601String(),
      'questions':
          questions.map((question) => question.questionToMap()).toList(),
    };
  }

  // Create Quiz from Map
  static Quiz quizFromMap(Map<String, dynamic> map) {
    try {
      return Quiz()
        ..quizID = map['quizID'] ?? ""
        ..teacherID = map['teacherID'] ?? ""
        ..studentID = map['studentID'] ?? ""
        ..quizMode = map['quizMode'] ?? "creation"
        ..title = map['title'] ?? ""
        ..description = map['description'] ?? ""
        ..start_date =
            map['start_date'] != null ? DateTime.parse(map['start_date']) : null
        ..end_date =
            map['end_date'] != null ? DateTime.parse(map['end_date']) : null
        ..questions = (map['questions'] as List<dynamic>)
            .map((questionMap) => Question.questionFromMap(questionMap))
            .toList()
            .cast<Question>();
    } catch (e) {
      return Quiz();
    }
  }
}


  // Future<void> submit() async {
  //   await saveResultsToDB();
  // }

  
  /// Save the Quiz to Firestore
  // Future<void> saveToDB() async {
  //   final quizCollection = FirebaseFirestore.instance.collection('quizzes');
  //   final questionCollection =
  //       FirebaseFirestore.instance.collection('questions');

  //   // Save quiz
  //   final docRef = quizID.isEmpty
  //       ? await quizCollection.add(quizToMap())
  //       : quizCollection.doc(quizID);
  //   if (quizID.isEmpty) {
  //     quizID = docRef.id; // Assign generated Firestore ID
  //   } else {
  //     await docRef.set(quizToMap());
  //   }

  //   // Save associated questions
  //   for (var question in questions) {
  //     question.quizId = quizID; // Ensure question has the quiz ID
  //     await question.saveToDB(questionCollection);
  //   }
  // }

  /// Retrieve Quiz and its Questions from Firestore
  // static Future<Quiz> retrieveFromDB(String quizId) async {
  //   final quizCollection = FirebaseFirestore.instance.collection('quizzes');
  //   final questionCollection =
  //       FirebaseFirestore.instance.collection('questions');

  //   // Retrieve quiz
  //   final quizSnapshot = await quizCollection.doc(quizId).get();
  //   if (!quizSnapshot.exists) {
  //     throw Exception("Quiz with ID $quizId not found.");
  //   }

  //   final quizData = quizSnapshot.data()!;
  //   Quiz quiz = Quiz.fromMap(quizData);
  //   quiz.quizID = quizId;

  //   // Retrieve associated questions
  //   final questionSnapshot =
  //       await questionCollection.where('quizId', isEqualTo: quizId).get();
  //   quiz.questions = questionSnapshot.docs.map((doc) {
  //     Question newQuestion = Question();
  //     newQuestion.fromMap(doc.data());

  //     return newQuestion;
  //   }).toList();

  //   return quiz;
  // }




