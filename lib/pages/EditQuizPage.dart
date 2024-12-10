import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizify/components/AdminCustomNavBar.dart';
import 'package:quizify/pages/CreateQuestionPage.dart';
import '../components/CustomNavBar.dart';
import '../models/Quiz.dart';
import 'package:quizify/components/CustomNavBar.dart';

class EditQuizPage extends StatefulWidget {
  final Quiz quiz;
  const EditQuizPage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<EditQuizPage> createState() => _EditQuizPageState();
}

class _EditQuizPageState extends State<EditQuizPage> {
  late Quiz quiz;
  late TextEditingController newnamecontroller;
  late TextEditingController newdescriptioncontroller;
  late TextEditingController newstartdatecontroller;
  late TextEditingController newstartdatestringcontroller;
  late TextEditingController newenddatecontroller;
  late TextEditingController newenddatestringcontroller;
  late DateTime now;
  late DateTime oneYearLater;
  late DateTime oneYearAgo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz = widget.quiz;
    newnamecontroller = TextEditingController(text: quiz.title);
    newdescriptioncontroller = TextEditingController(text: quiz.description);

    newstartdatecontroller =
        TextEditingController(text: quiz.start_date?.toIso8601String());
    newstartdatestringcontroller =
        TextEditingController(text: quiz.start_date?.toIso8601String());

    newenddatecontroller =
        TextEditingController(text: quiz.end_date?.toIso8601String());
    newenddatestringcontroller =
        TextEditingController(text: quiz.end_date?.toIso8601String());

    now = DateTime.now();
    oneYearLater = DateTime(
        now.year + 1, now.month, now.day, now.hour, now.minute, now.second);
    oneYearAgo = now.subtract(Duration(days: 365));

    // print(quizIdFrom)
    // fetchQuizData();
  }

  // fetchQuizData() async {
  // DocumentReference docRef =
  //     FirebaseFirestore.instance.collection("quizzes").doc(quizID);

  // docRef.get().then((value) {
  //   // get the previouse values and put them in the controlllers
  // this.newnamecontroller = value.get('title') ?? '';
  // this.newdescriptioncontroller = value.get('description') ?? '';
  // this.newstartdatecontroller = value.get('start_date') ?? '';
  // this.newenddatecontroller = value.get('end_date') ?? '';
  // });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Quiz'),
      ),
      bottomNavigationBar: AdminCustomNavBar(page_url: '/allTeacherQuizzes'),
      body: Column(
        children: [
          Text("edit quiz title"),
          TextField(
            controller: newnamecontroller,
            onChanged: (newTitle) {
              quiz.title = newTitle;
            },
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Text("edit quiz description"),
          TextField(
            controller: newdescriptioncontroller,
            onChanged: (newDes) {
              quiz.description = newDes;
            },
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
                initialDate: quiz.start_date,
                firstDate: oneYearAgo,
                lastDate: oneYearLater,
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
                      quiz.start_date = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );

                      newenddatecontroller.text =
                          finalDateTime.toString(); // For display
                      newenddatestringcontroller.text =
                          finalDateTime.toIso8601String(); // Or an
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
                initialDate: quiz.end_date,
                firstDate: quiz.start_date ?? oneYearAgo,
                lastDate: oneYearLater,
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

                      quiz.end_date = DateTime(
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
          FloatingActionButton(
              child: Text('continue'),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CreateQuestionPage(quiz: quiz)));
                // print(newnamecontroller.text);
                // DocumentReference docRef = FirebaseFirestore.instance
                //     .collection("quizzes")
                //     .doc("9AL69xXRu3Vr2bbu9O6s"); //hard coded quiz id

                // Map<String, dynamic> Item = {
                //   "title": newnamecontroller.text,
                //   "description": newdescriptioncontroller.text,
                //   "end_date": newstartdatestringcontroller.text,
                //   "start_date": newenddatestringcontroller.text
                // };

                // docRef.set(Item).whenComplete(() {
                //   print("updated!");
                // });
              })
        ],
      ),
    );
  }
}
