import 'package:flutter/material.dart';
import 'package:quizify/models/Question.dart';

class TrueFalse extends StatefulWidget {
  const TrueFalse({
    super.key,
    required this.selectedAnswer,
    required this.onAnswerChanged,
  });

  // Pass the initial answer state and a callback for changes
  final bool selectedAnswer;
  final ValueChanged<bool> onAnswerChanged;

  @override
  State<TrueFalse> createState() => _TrueFalseState();
}

class _TrueFalseState extends State<TrueFalse> {
  late bool selectedAnswer;

  @override
  void initState() {
    super.initState();
    selectedAnswer = widget.selectedAnswer; // Initialize from parent
  }

  void updateAnswer(bool value) {
    setState(() {
      selectedAnswer = value;
    });
    widget.onAnswerChanged(value); // Notify parent of the change
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: Question.trueFalseValues
          .map((e) => RadioListTile<bool>(
                value: e['value'],
                title: Text(e['title']),
                groupValue: selectedAnswer,
                onChanged: (value) {
                  if (value != null) {
                    updateAnswer(value);
                  }
                },
              ))
          .toList(),
    );
  }
}
