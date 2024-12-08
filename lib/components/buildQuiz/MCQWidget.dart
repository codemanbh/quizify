import 'package:flutter/material.dart';

class MCQWidget extends StatefulWidget {
  final String questionText;
  final List<String> possibleAnswers;
  final String selectedAnswer;
  final ValueChanged<String>
      onAnswerSelected; // Fix: Changed to match the type of selectedAnswer

  MCQWidget({
    required this.questionText,
    required this.possibleAnswers,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    Key? key, // Fix: Added the key parameter
  }) : super(key: key);

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _selectedAnswer =
        widget.selectedAnswer; // Initialize with the provided selected answer
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.questionText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        for (var i = 0; i < widget.possibleAnswers.length; i++)
          RadioListTile<String>(
            title: Text(widget.possibleAnswers[i]),
            value: widget
                .possibleAnswers[i], // Fix: Use the correct value from the list
            groupValue:
                _selectedAnswer, // This ensures the selected answer is highlighted
            onChanged: (value) {
              setState(() {
                _selectedAnswer = value; // Update the state with the new value
              });
              if (value != null) {
                widget.onAnswerSelected(value); // Notify the parent widget
              }
            },
          ),
      ],
    );
  }
}
