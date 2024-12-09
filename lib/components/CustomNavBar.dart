import 'package:flutter/material.dart';
import '../models/AuthManager.dart';

class CustomNavBar extends StatefulWidget {
  final String page_url;
  const CustomNavBar({Key? key, required this.page_url}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  String page_url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page_url = widget.page_url;
  }
  // AuthManager authM = AuthManager();

  @override
  Widget build(BuildContext context) {
    List pages = ['/enterQuizIdPage', '/allStudentAttempts', '/profilePage'];

    int currentIndex = pages.indexOf(page_url);

    if (currentIndex < 0 || currentIndex > pages.length - 1) {
      currentIndex = 0;
    }
    return BottomNavigationBar(
        onTap: (index) {
          Navigator.of(context).pushReplacementNamed(pages[index]);
        },
        // pages.indexOf(page_url)
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.input), label: 'enter quiz'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'attempts'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account'),
        ]);
  }
}
