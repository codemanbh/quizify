import 'package:flutter/material.dart';
import '../models/placehilderQuizes.dart';
import '../models/Quiz.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                // placeHolderQuizes.quiz1.saveToDB();

                Quiz q = placeHolderQuizzes.quiz1;

                print(q.title);
              },
              child: Text('save quiz'))
        ],
      ),
    );
  }
}
