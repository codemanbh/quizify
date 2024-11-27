import 'package:flutter/material.dart';

class Written extends StatefulWidget {
  const Written({super.key});

  @override
  State<Written> createState() => _WrittenState();
}

class _WrittenState extends State<Written> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(label: Text('Correct answer')),
        )
      ],
    );
  }
}
