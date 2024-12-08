import 'package:flutter/material.dart';

class AdminCustom extends StatefulWidget {
  const AdminCustom({super.key});

  @override
  State<AdminCustom> createState() => _AdminCustom();
}

class _AdminCustom extends State<AdminCustom> {
  @override
  Widget build(BuildContext context) {
    List pages = ['/AdminProfilePage', '/createQuiestionPage'];
    return BottomNavigationBar(
        onTap: (index) {
          Navigator.of(context).pushReplacementNamed(pages[index]);
        },
        items: [
         BottomNavigationBarItem(icon: Icon(Icons.web), label: 'Question'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account')
        ]);
  }
}