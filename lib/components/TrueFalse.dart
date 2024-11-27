import 'package:flutter/material.dart';
import 'package:quizify/models/Question.dart';

class TrueFalse extends StatefulWidget {
  const TrueFalse({super.key});

  @override
  State<TrueFalse> createState() => _TrueFalseState();
}

class _TrueFalseState extends State<TrueFalse> {
  bool selectedAnswer = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: Question.TrueFalseValues.map((e) => RadioListTile(
            value: e['value'],
            title: Text(e['title']),
            groupValue: selectedAnswer,
            onChanged: (v) {
              if (v != null) {
                selectedAnswer = v;
                setState(() {});
              }
            },
          )).toList(),
    );
  }
}
