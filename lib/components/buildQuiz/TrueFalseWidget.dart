import 'package:flutter/material.dart';
import '../../models/Question.dart';

class TrueFalseWidget extends StatefulWidget {
  final String questionText;
  final String? selectedValue;
  final ValueChanged<String> onValueSelected;

  TrueFalseWidget({
    required this.questionText,
    required this.selectedValue,
    required this.onValueSelected,
  });

  @override
  _TrueFalseWidgetState createState() => _TrueFalseWidgetState();
}

class _TrueFalseWidgetState extends State<TrueFalseWidget> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
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
        for (var option in Question.trueFalseValues)
          RadioListTile<String>(
            title: Text(option["title"]),
            value: option["value"],
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
              if (value != null) widget.onValueSelected(value);
            },
          ),
      ],
    );
  }
}
