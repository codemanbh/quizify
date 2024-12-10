import 'package:flutter/material.dart';
import 'package:quizify/components/AdminCustomNavBar.dart';
import 'package:quizify/components/CustomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizify/components/StudentAttemptsSearch.dart';
import 'package:quizify/models/Quiz.dart';
import './StudentResults.dart';

class AllStudentAttempts extends StatefulWidget {
  const AllStudentAttempts({super.key});

  @override
  State<AllStudentAttempts> createState() => _AllStudentAttemptsState();
}

class _AllStudentAttemptsState extends State<AllStudentAttempts> {
  List<Quiz> attempts = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStudentAttempts();
  }

// .where('studentID', isEqualTo: uid)
  fetchStudentAttempts() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = await _auth.currentUser;
    String uid = await user?.uid ?? '';
    List<Quiz> attemptsTemp = [];

    CollectionReference attemptsRef =
        FirebaseFirestore.instance.collection('attempts');

    attemptsRef.where('studentID', isEqualTo: uid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((oneMap) {
        Quiz newQ = Quiz.quizFromMap(oneMap.data() as Map<String, dynamic>);
        attemptsTemp.add(newQ);
      });

      // print()

      attemptsTemp.forEach((atmpTemp) {
        if (atmpTemp.studentID == uid) {
          attempts.add(atmpTemp);
        }
      });
      // attempts = attempts.map((oneQuiz){})
      isLoading = false;
      setState(() {});
    });
  }

  void viewAttemptDetail(String attemptID) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentResults(attemptID: attemptID)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done quizzes'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: StudentAttemptsSearch());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: attempts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(attempts[index].title ?? ''),
                    trailing: TextButton(
                      onPressed: () =>
                          viewAttemptDetail(attempts[index].attemptID),
                      child: Text(
                          "${attempts[index]?.studentGrade}/${attempts[index].questions.length}"),
                    ));
              },
            ),
      bottomNavigationBar: CustomNavBar(page_url: '/allStudentAttempts'),
    );
  }
}
