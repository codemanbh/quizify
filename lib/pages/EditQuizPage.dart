import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizify/components/CustomNavBar.dart';

class EditQuizPage extends StatefulWidget {
  const EditQuizPage({super.key});

  @override
  State<EditQuizPage> createState() => _EditQuizPageState();
}

class _EditQuizPageState extends State<EditQuizPage> {
  @override
  TextEditingController newname = TextEditingController();
  TextEditingController newdescription = TextEditingController();
  TextEditingController newstartdate = TextEditingController();
  TextEditingController newstartdatestring = TextEditingController();
  TextEditingController newenddate = TextEditingController();
  TextEditingController newenddatestring = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz questions'),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          Text("edit quiz title"),
          TextField(
            controller: newname,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Text("edit quiz description"),
          TextField(
            controller: newdescription,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Text("edit quiz start date"),
          TextField(
            controller: newstartdate,
            readOnly: true, // Prevent manual input
            onTap: () {
              // Trigger DatePicker on tap
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  // Update both controllers with the selected date
                  newstartdate.text = selectedDate.toString(); // For display
                  newstartdatestring.text =
                      selectedDate.toIso8601String(); // Or another format
                }
              });
            },
            decoration: InputDecoration(
              hintText: 'Select a start date',
            ),
          ),
          TextField(
            controller: newenddate,
            readOnly: true, // Prevent manual input
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  // Update both controllers with the selected date
                  newenddate.text = selectedDate.toString(); // For display
                  newenddatestring.text =
                      selectedDate.toIso8601String(); // Or another format
                }
              });
            },
            decoration: InputDecoration(
              hintText: 'Select a start date',
            ),
          ),
        ],
      ),
    );
  }
}
