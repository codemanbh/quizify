import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';

class TakeQuizPage extends StatefulWidget {
  const TakeQuizPage({super.key});

  @override
  State<TakeQuizPage> createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'] ?? "<title not found>";
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      appBar: AppBar(
        title: Text(title), // change later to quiz name
      ),
    );
  }
}
