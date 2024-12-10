import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';
import '../models/Quiz.dart';
import '../models/placehilderQuizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../components/buildQuiz/MCQWidget.dart';
import '../components/buildQuiz/TrueFalseWidget.dart';
import '../components/buildQuiz/WrittenWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/CountdownTimer.dart';

class TakeQuizPage extends StatefulWidget {
  final Quiz quiz;
  const TakeQuizPage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<TakeQuizPage> createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  late Quiz quiz;
  List<Widget> listOfQuestions = [];
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("asdasdadas");
    quiz = widget.quiz;
    initPage();
  }

  initPage() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;

    // final answersMap = getAnswersMap(user!.uid);
    setState(() {});
  }

  void submitAnswer() async {
    await quiz.submitQuizStudent();
    Navigator.of(context).pushReplacementNamed('/allStudentAttempts');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Time has finished!')),
    );
  }
  // int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(page_url: '/takeQuizPage'),
      appBar: AppBar(
        title: Text(quiz.title), // change later to quiz name
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            CountdownTimer(
              startTime: quiz.start_date ?? DateTime.now(),
              endTime:
                  quiz.end_date ?? DateTime.now(), // Example target end time
              onFinish: () {
                // Action to perform when the timer finishes
                submitAnswer();
                print("The countdown has finished!");
              },
            ),
            Column(
                children: quiz.questions.asMap().entries.map((entry) {
              final index = entry.key;
              final question = entry.value;

              switch (question.question_type) {
                case "MCQ":
                  return MCQWidget(
                    questionText: question.question_text,
                    possibleAnswers: question.possibleMcqAnswers,
                    selectedAnswer: question.studentSelectedAnswer ?? '',
                    onAnswerSelected: (value) {
                      quiz.questions[index].studentSelectedAnswer = value;
                    },
                  );
                case "TF":
                  return TrueFalseWidget(
                    questionText: question.question_text,
                    selectedValue: question.studentSelectedAnswer,
                    onValueSelected: (value) {
                      question.studentSelectedAnswer =
                          value; // Fixed the field update
                    },
                  );
                case "WRITTEN":
                  return WrittenWidget(
                    questionText: question.question_text,
                    initialAnswer: question.studentSelectedAnswer,
                    onAnswerChanged: (value) {
                      question.studentSelectedAnswer = value;
                    },
                  );
                default:
                  return SizedBox();
              }
            }).toList()),
            SizedBox(
              height: 40,
            ),
            TextButton(onPressed: submitAnswer, child: Text('Submit answer')),
            Text(user?.uid ?? 'no user found')
          ],
        ),
      ),
    );
  }
}
