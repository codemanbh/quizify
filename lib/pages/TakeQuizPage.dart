import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';
import '../models/Quiz.dart';
import '../models/placehilderQuizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

class TakeQuizPage extends StatefulWidget {
  const TakeQuizPage({super.key});

  @override
  State<TakeQuizPage> createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  Quiz quiz = Quiz();
  List<Widget> listOfQuestions = [];
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("asdasdadas");

    initPage();
  }

  initPage() async {
    // Map<String, dynamic>? args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // String qid = args?['qid'] ?? "<title not found>";

    // print(qid);

    // quiz = await Quiz.retrieveFromDB('1');
    quiz = placeHolderQuizzes.quiz1;

    // print("asdasdadas" + quiz.title);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;

    // final answersMap = getAnswersMap(user!.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      appBar: AppBar(
        title: Text(quiz.title), // change later to quiz name
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
                children: quiz.questions
                    .map((question) => question.questionToWidget())
                    .toList()),
            SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () async {
                  await quiz.submit();
                },
                child: Text('Submit answer')),
            Text(user?.uid ?? 'no user found')
          ],
        ),
      ),
    );
  }
}
