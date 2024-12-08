import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';
import '../models/Quiz.dart';
import '../models/placehilderQuizes.dart';

class TakeQuizPage extends StatefulWidget {
  const TakeQuizPage({super.key});

  @override
  State<TakeQuizPage> createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  Quiz quiz = Quiz();
  List<Widget> listOfQuestions = [];

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

    quiz = await Quiz.retrieveFromDB('1');
    // quiz = placeHolderQuizes.quiz1;

    // print("asdasdadas" + quiz.title);

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
                    .map((question) => question.toWidget())
                    .toList()),
            SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {
                  print(quiz.getAnswersMap('1'));
                },
                child: Text('Submit answer'))
          ],
        ),
      ),
    );
  }
}
