import 'package:flutter/material.dart';
import 'package:quizify/components/AdminCustomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizify/models/Quiz.dart';
import 'package:quizify/pages/EditQuizPage.dart';
import 'package:quizify/pages/GradeStudentAnswer.dart';
import './CreateQuestionPage.dart';
import 'package:flutter/services.dart';

class allTeacherQuizzes extends StatefulWidget {
  const allTeacherQuizzes({super.key});

  @override
  State<allTeacherQuizzes> createState() => _allTeacherQuizzesState();
}

class _allTeacherQuizzesState extends State<allTeacherQuizzes> {
  Quiz? quiz;
  bool isLoading = true;
  List<Quiz> quizzes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    queryQuiz();
  }

  queryQuiz() async {
    try {
      isLoading = true;
      setState(() {});
      CollectionReference colRef =
          FirebaseFirestore.instance.collection('quizzes');
      QuerySnapshot querySnapshot = await colRef.get();
      // print('Raw documents: ${querySnapshot.docs}');

      quizzes = querySnapshot.docs.map((oneQuiz) {
        Quiz newQ = Quiz.quizFromMap(oneQuiz.data() as Map<String, dynamic>);
        newQ.quizID = oneQuiz.id;
        return newQ;
      }).toList();

      // querySnapshot.docs
      //     .forEach((snapShot , index) =>  quiz_.quizID);

      // quiz = Quiz.quizFromMap(docSnap.data() as Map<String, dynamic>);
    } catch (e) {
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Quizzes')),
      bottomNavigationBar: AdminCustomNavBar(
        page_url: '/allTeacherQuizzes',
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: quizzes.length,
                itemBuilder: (context, index) => Card(
                    child: ListTile(
                  title: Text(quizzes[index].title ?? ''),
                  leading: IconButton(
                      onPressed: () async {
                        await quizzes[index].deleteQuiz();
                        queryQuiz();
                      },
                      icon: Icon(Icons.delete)),
                  subtitle: Text(quizzes[index].description ?? '',
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                      text: quizzes[index].quizID))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Quiz ID is copied')),
                                );
                              });
                            },
                            icon: Icon(Icons.copy)),
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GradeStudentAnswer(
                                    quizID: quizzes[index].quizID ?? '',
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.person)),
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditQuizPage(quiz: quizzes[index])
                                    // CreateQuestionPage(quiz: quizzes[index]),
                                    ),
                              );
                            },
                            icon: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                )),
              ),
            ),
    );
  }
}
