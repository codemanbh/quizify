import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizify/models/DatabaseManagers/QuizDatabaseManager.dart';
import 'package:quizify/models/Question.dart';
import 'package:quizify/models/Quiz.dart';
import '../components/CustomNavBar.dart';

class StudentResults extends StatefulWidget {
  final String attemptID;
  StudentResults({Key? key, required this.attemptID}) : super(key: key);

  @override
  State<StudentResults> createState() => _StudentResultsState();
}

class _StudentResultsState extends State<StudentResults> {
  Quiz? fetchedQuiz;
  String attemptID = '';

  @override
  void initState() {
    super.initState();
    attemptID = widget.attemptID ?? '';
    fetchQuiz(); // Call fetchQuiz in initState to load the data when the widget is created
  }

  void fetchQuiz() async {
    QuizDatabaseManager quizManager = QuizDatabaseManager();
    // String attemptID = "8B04DHbPBtcldRKnY85M";

    try {
      // Fetch the quiz (await the result since getQuiz is asynchronous)
      Quiz? quiz = await quizManager.getAttempt(attemptID);

      setState(() {
        fetchedQuiz = quiz; // Update the fetchedQuiz state
      });

      if (quiz != null) {
        print("Quiz Title: ${quiz.title}");
        print("Description: ${quiz.description}");
        print("Start Date: ${quiz.start_date}");
        print("End Date: ${quiz.end_date}");
        print("Number of Questions: ${quiz.questions.length}");
        print("Question Count: ${quiz.questions.length}");
      } else {
        print("Quiz with ID $attemptID does not exist.");
      }
    } catch (e) {
      print("An error occurred while fetching the quiz: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Your Results"),
      ),
      body: fetchedQuiz == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show a spinner while loading
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    fetchedQuiz!.title,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    "You scored: ${fetchedQuiz!.studentGrade}/${fetchedQuiz!.questions.length} marks",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Quiz Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: fetchedQuiz!.questions.length,
                    itemBuilder: (context, index) {
                      Question question = fetchedQuiz!.questions[index];
                      return ListTile(
                        shape: Border(bottom: BorderSide(color: Colors.grey)),
                        title: Text(
                          "Question ${index + 1}: ${question.question_text}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Correct answer: ${question.teacherCorrectAnswer}",
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                                "Seelected answer: ${question.studentSelectedAnswer}")
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomNavBar(page_url: '/allStudentAttempts'),
    );
  }
}
