import 'package:flutter/material.dart';

class AdminCustomNavBar extends StatefulWidget {
  const AdminCustomNavBar({super.key});

  @override
  State<AdminCustomNavBar> createState() => _AdminCustomNavBar();
}

class _AdminCustomNavBar extends State<AdminCustomNavBar> {
  @override
  Widget build(BuildContext context) {
    List pages = [
      '/createQuizPage',
      '/allTeacherQuizzes',
      '/AdminProfilePage',
    ];
    return BottomNavigationBar(
        onTap: (index) {
          Navigator.of(context).pushReplacementNamed(pages[index]);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.web), label: 'Create Quiz'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'all Quizzes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account')
        ]);
  }
}
