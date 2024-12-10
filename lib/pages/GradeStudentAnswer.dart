import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizify/components/AdminCustomNavBar.dart';
import 'package:quizify/models/Quiz.dart';
import 'package:quizify/pages/StudentResults.dart';

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

  Future<String?> getUserName(String userId) async {
    try {
      // Reference the Firestore collection
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // Safely cast the data to Map<String, dynamic>
        final data = userDoc.data() as Map<String, dynamic>?;
        return data?['name'] as String?;
      } else {
        print('User with ID $userId not found.');
        return null;
      }
    } catch (e) {
      print('Error fetching user name: $e');
      return null;
    }
  }

  fetchAttemtps() async {
    CollectionReference attemptsCollectionRef =
        FirebaseFirestore.instance.collection('attempts');
// 'KWFiut2xBNIyXUHskZmY'
    QuerySnapshot attemptsSnapShot =
        await attemptsCollectionRef.where('quizID', isEqualTo: quizID).get();

    attemptsSnapShot.docs.forEach((attemptMap) {
      Quiz oneAttempt;
      print(attemptMap.data());
      oneAttempt = Quiz.quizFromMap(attemptMap.data() as Map<String, dynamic>);
      attempts.add(oneAttempt);

      // oneAttempt.attemptID =
    });

    setState(() {
      isLoading = false;
    });
  }

  String stuName = '';

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
                // print(attempts[index].quizToMap());
                getUserName(attempts[index].studentID).then((newStuName) {
                  setState(() {
                    stuName = newStuName ?? 'b';
                  });
                });
                return Card(
                  child: ListTile(
                    title: Text(stuName),
                    trailing: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentResults(
                                      attemptID: attempts[index].attemptID)));
                        },
                        child: Text(
                            '${attempts[index].studentGrade}/${attempts[index].questions.length}')),
                  ),
                );
              }),
      // body: ,
    );
  }
}
