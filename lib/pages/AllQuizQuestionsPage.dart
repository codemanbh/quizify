import 'package:flutter/material.dart';
import '../../models/Question.dart';
import '../../models/Quiz.dart';
import '../components/CustomNavBar.dart';

class AllQuizQuestionsPage extends StatefulWidget {
  const AllQuizQuestionsPage({super.key});

  @override
  State<AllQuizQuestionsPage> createState() => _AllQuizQuestionsPageState();
}

class _AllQuizQuestionsPageState extends State<AllQuizQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      appBar: AppBar(
        title: Text('Quiz questions'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Text((index + 1).toString()),
            ),
          );
        },
      ),
    );
  }
}
