import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/CustomNavBar.dart';
import './TakeQuizPage.dart';
import '../models/Quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EnterQuizIdPage extends StatefulWidget {
  const EnterQuizIdPage({super.key});

  @override
  State<EnterQuizIdPage> createState() => _EnterQuizIdPageState();
}

class _EnterQuizIdPageState extends State<EnterQuizIdPage> {
  TextEditingController qidCtr = TextEditingController();
  final quizCollection = FirebaseFirestore.instance.collection('quizzes');
  final questionCollection = FirebaseFirestore.instance.collection('questions');
  final attemptCollection = FirebaseFirestore.instance.collection('attempts');
  @override
  Widget build(BuildContext context) {
    takeQuiz() async {
      String quizId = qidCtr.value.text.trim();
      if (quizId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'The valid quiz ID should not be empty!',
              style: TextStyle(color: Colors.red[700]),
            ),
            backgroundColor: Colors.white,
          ),
        );
        return;
      }

      DocumentSnapshot docSnapshot = await quizCollection.doc(quizId).get();

      if (!docSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'The quiz ID does not exist.',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.white,
          ),
        );
        return;
      }

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;

      QuerySnapshot attempts = await attemptCollection
          .where('studentID', isEqualTo: user?.uid)
          .where('quizID', isEqualTo: quizId)
          .get();

      if (!attempts.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You already solved the quiz',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.white,
          ),
        );

        Navigator.of(context).pushReplacementNamed('/allStudentAttempts');
        return;
      }

      Map<String, dynamic> quizData =
          docSnapshot.data() as Map<String, dynamic>;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TakeQuizPage(
              quiz:
                  Quiz.quizFromMap(docSnapshot.data() as Map<String, dynamic>)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Take Quiz'),
      ),
      bottomNavigationBar: CustomNavBar(page_url: '/enterQuizIdPage'),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                Text("Enter quiz ID to take the quiz"),
                TextField(
                  controller: qidCtr,
                  decoration: InputDecoration(
                    hintText: 'Enter quiz ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextButton(onPressed: takeQuiz, child: Text('Enter quiz')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
