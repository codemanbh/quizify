import 'package:flutter/material.dart';

class MCQWidget extends StatefulWidget {
  final String questionText;
  final List<String> possibleAnswers;
  final int? selectedAnswer;
  final ValueChanged<int> onAnswerSelected;

  MCQWidget({
    required this.questionText,
    required this.possibleAnswers,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
}

class _MCQWidgetState extends State<MCQWidget> {
  int? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _selectedAnswer = widget.selectedAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.questionText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        for (var i = 0; i < widget.possibleAnswers.length; i++)
          RadioListTile<int>(
            title: Text(widget.possibleAnswers[i]),
            value: i,
            groupValue: _selectedAnswer,
            onChanged: (value) {
              setState(() {
                _selectedAnswer = value;
              });
              if (value != null) widget.onAnswerSelected(value);
            },
          ),
      ],
    );
  }
}
