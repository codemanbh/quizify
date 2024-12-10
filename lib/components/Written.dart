import 'package:flutter/material.dart';

class Written extends StatefulWidget {
  const Written({super.key, required this.controller});

  // Pass a controller from the parent widget
  final TextEditingController controller;

  @override
  State<Written> createState() => _WrittenState();
}

class _WrittenState extends State<Written> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller:
              widget.controller, // Use the controller passed from parent
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            label: Text('Correct answer'),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
