import 'package:flutter/material.dart';

class WrittenWidget extends StatefulWidget {
  final String questionText;
  final String? initialAnswer;
  final ValueChanged<String> onAnswerChanged;

  WrittenWidget({
    required this.questionText,
    required this.initialAnswer,
    required this.onAnswerChanged,
  });

  @override
  _WrittenWidgetState createState() => _WrittenWidgetState();
}

class _WrittenWidgetState extends State<WrittenWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialAnswer);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Write your answer here",
            border: OutlineInputBorder(),
          ),
          onChanged: widget.onAnswerChanged,
        ),
      ],
    );
  }
}
