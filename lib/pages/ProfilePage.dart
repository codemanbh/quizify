import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: John_Doe123'),
            Text('Name: John Doe'),
            Text('Email: example@gmail.com'),
            TextButton(onPressed: () {}, child: Text("Signout"))
          ],
        ),
      ),
    );
  }
}
