import 'package:flutter/material.dart';

class TrueFalse extends StatefulWidget {
  const TrueFalse({
    super.key,
    required this.trueLabel,
    required this.falseLabel,
    required this.selectedAnswer,
    required this.onAnswerChanged,
  });

  final String trueLabel; // Text for the true option
  final String falseLabel; // Text for the false option
  final bool selectedAnswer; // Current selected value
  final ValueChanged<bool> onAnswerChanged; // Callback for changes

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
      children: [
        RadioListTile<bool>(
          value: true,
          title: Text(widget.trueLabel), // Custom true label
          groupValue: selectedAnswer,
          onChanged: (value) {
            if (value != null) {
              updateAnswer(value);
            }
          },
        ),
        RadioListTile<bool>(
          value: false,
          title: Text(widget.falseLabel), // Custom false label
          groupValue: selectedAnswer,
          onChanged: (value) {
            if (value != null) {
              updateAnswer(value);
            }
          },
        ),
      ],
    );
  }
}
