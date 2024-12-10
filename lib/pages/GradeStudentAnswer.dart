import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizify/components/AdminCustomNavBar.dart';
import 'package:quizify/models/Quiz.dart';

class GradeStudentAnswer extends StatefulWidget {
  final String quizID;
  const GradeStudentAnswer({Key? key, required this.quizID}) : super(key: key);

  @override
  State<GradeStudentAnswer> createState() => _GradeStudentAnswerState();
}

class _GradeStudentAnswerState extends State<GradeStudentAnswer> {
  late String quizID;
  List<Quiz> attempts = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizID = widget.quizID;
    print('aaaaaaaaaaaaaaaaaaaaaa');
    print(quizID);

    fetchAttemtps();
  }

  fetchAttemtps() async {
    CollectionReference attemptsCollectionRef =
        FirebaseFirestore.instance.collection('attempts');

    QuerySnapshot attemptsSnapShot =
        await attemptsCollectionRef.where('quizID', isEqualTo: quizID).get();

    attemptsSnapShot.docs.forEach((attemptMap) {
      Quiz oneAttempt = Quiz();
      try {
        oneAttempt = Quiz.quizFromMap(attemptMap as Map<String, dynamic>);
      } catch (e) {}
      // oneAttempt.attemptID =
      attempts.add(oneAttempt);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students attempts')),
      bottomNavigationBar: AdminCustomNavBar(page_url: '/allTeacherQuizzes'),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: attempts.length,
              itemBuilder: (context, index) {
                print(attempts[index].quizToMap());
                return Card(
                  child: ListTile(
                    title: Text(attempts[index].studentID),
                  ),
                );
              }),
      // body: ,
    );
  }
}
