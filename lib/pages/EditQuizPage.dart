import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/CustomNavBar.dart';
import '../models/Quiz.dart';
import 'package:quizify/components/CustomNavBar.dart';

class EditQuizPage extends StatefulWidget {
  const EditQuizPage({super.key});

  @override
  State<EditQuizPage> createState() => _EditQuizPageState();
}

class _EditQuizPageState extends State<EditQuizPage> {
  @override
  TextEditingController newnamecontroller = TextEditingController();
  TextEditingController newdescriptioncontroller = TextEditingController();
  TextEditingController newstartdatecontroller = TextEditingController();
  TextEditingController newstartdatestringcontroller = TextEditingController();
  TextEditingController newenddatecontroller = TextEditingController();
  TextEditingController newenddatestringcontroller = TextEditingController();

  Widget build(BuildContext context) {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("quizzes")
        .doc("9AL69xXRu3Vr2bbu9O6s");

    docRef.get().then((value) {
      // get the previouse values and put them in the controlllers
      this.newnamecontroller = value.get('title') ?? '';
      this.newdescriptioncontroller = value.get('description') ?? '';
      this.newstartdatecontroller = value.get('start_date') ?? '';
      this.newenddatecontroller = value.get('end_date') ?? '';
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Quiz'),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          Text("edit quiz title"),
          TextField(
            controller: newnamecontroller,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Text("edit quiz description"),
          TextField(
            controller: newdescriptioncontroller,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Text("edit quiz start date"),
          TextField(
            controller: newstartdatecontroller,
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
                  // Trigger TimePicker after selecting a date
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((selectedTime) {
                    if (selectedTime != null) {
                      // Combine selected date and time
                      final DateTime finalDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );

                      // Update controllers with the selected date and time
                      newstartdatecontroller.text =
                          finalDateTime.toString(); // For display
                      newstartdatestringcontroller.text =
                          finalDateTime.toIso8601String(); // Or another format
                    }
                  });
                }
              });
            },
            decoration: const InputDecoration(
              hintText: 'Select a start date and time',
            ),
          ),
          TextField(
            controller: newstartdatecontroller,
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
                  // Trigger TimePicker after selecting a date
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((selectedTime) {
                    if (selectedTime != null) {
                      // Combine selected date and time
                      final DateTime finalDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );

                      // Update controllers with the selected date and time
                      newenddatecontroller.text =
                          finalDateTime.toString(); // For display
                      newenddatestringcontroller.text =
                          finalDateTime.toIso8601String(); // Or another format
                    }
                  });
                }
              });
            },
            decoration: const InputDecoration(
              hintText: 'Select a start date and time',
            ),
          ),
          FloatingActionButton(onPressed: () {
            print(newnamecontroller.text);
            DocumentReference docRef = FirebaseFirestore.instance
                .collection("quizzes")
                .doc("9AL69xXRu3Vr2bbu9O6s"); //hard coded quiz id

            Map<String, dynamic> Item = {
              "title": newnamecontroller.text,
              "description": newdescriptioncontroller.text,
              "end_date": newstartdatestringcontroller.text,
              "start_date": newenddatestringcontroller.text
            };

            docRef.set(Item).whenComplete(() {
              print("updated!");
            });
          })
        ],
      ),
    );
  }
}
