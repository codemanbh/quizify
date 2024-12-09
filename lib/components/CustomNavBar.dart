import 'package:flutter/material.dart';
import '../models/AuthManager.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  // AuthManager authM = AuthManager();

  @override
  Widget build(BuildContext context) {
    List pages = ['/enterQuizIdPage', '/profilePage'];
    return BottomNavigationBar(
        onTap: (index) {
          Navigator.of(context).pushReplacementNamed(pages[index]);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.input), label: 'enter quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account'),
        ]);
  }
}
