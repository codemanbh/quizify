import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/CustomNavBar.dart';

class EnterQuizIdPage extends StatefulWidget {
  const EnterQuizIdPage({super.key});

  @override
  State<EnterQuizIdPage> createState() => _EnterQuizIdPageState();
}

class _EnterQuizIdPageState extends State<EnterQuizIdPage> {
  TextEditingController qidCtr = TextEditingController();
  final quizCollection = FirebaseFirestore.instance.collection('quizzes');
  final questionCollection = FirebaseFirestore.instance.collection('questions');

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

      Map<String, dynamic> quizData = docSnapshot.data() as Map<String, dynamic>;
      Navigator.of(context).pushNamed('/takeQuizPage', arguments: {'qid': quizId, 'data': quizData});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Take Quiz'),
      ),
      bottomNavigationBar: CustomNavBar(),
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