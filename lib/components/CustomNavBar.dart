import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    List pages = ['/profilePage', '/allQuizesPage', '/enterQuizIdPage'];
    return BottomNavigationBar(
        onTap: (index) {
          Navigator.of(context).pushReplacementNamed(pages[index]);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account'),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: 'quizes'),
          BottomNavigationBarItem(icon: Icon(Icons.input), label: 'enter quiz'),
        ]);
  }
}
