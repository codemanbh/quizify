import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/CustomNavBar.dart';

class EnterQuizIdPage extends StatefulWidget {
  const EnterQuizIdPage({super.key});

  @override
  State<EnterQuizIdPage> createState() => _EnterQuizIdPageState();
}

class _EnterQuizIdPageState extends State<EnterQuizIdPage> {
  TextEditingController qidCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    takeQuiz() {
      Navigator.of(context)
          .pushNamed('/takeQuizPage', arguments: {'qid': qidCtr.value.text});
      // Navigator.of(context).pushNamed('/takeQuizPage', );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Take Quiz'),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          Text("Enter quiz ID to take the quiz"),
          TextField(
            controller: qidCtr,
          ),
          TextButton(onPressed: takeQuiz, child: Text('Enter quiz'))
        ],
      ),
    );
  }
}
