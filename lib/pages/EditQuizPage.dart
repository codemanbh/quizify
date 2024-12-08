import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';
import '../models/Quiz.dart';

class EditQuizPage extends StatefulWidget {
  const EditQuizPage({super.key});

  @override
  State<EditQuizPage> createState() => _EditQuizPageState();
}

class _EditQuizPageState extends State<EditQuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Quiz'),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
