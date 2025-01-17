// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';

// dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizify/pages/AdminProfilePage.dart';
import 'package:quizify/pages/ProfilePage.dart';

// pages
import './pages/CreateQuestionPage.dart';
import './pages/GradingPage.dart';
import './pages/ReportPage.dart';
import './pages/EditQuizPage.dart';
import './pages/QuizManagementPage.dart';
import './pages/StudentResults.dart';
import './pages/TakeQuizPage.dart';
import './pages/AllQuizQuestionsPage.dart';
import './pages/SignupPage.dart';
import './pages/AllQuizesPage.dart';
import './pages/TestPage.dart';
import './pages/LoginPage.dart';
import './pages/EnterQuizIdPage.dart';
import './pages/CreateQuizPage.dart';
import './pages/allTeacherQuizzes.dart';
import './pages/AllStudentAttempts.dart';

// timed qBfcBdYlchWj8VmNovCA
void main() async {
  await dotenv.load(fileName: 'assets/.env'); // loud the env variables

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // initilize firebase using the credentials in env
    options: FirebaseOptions(
      apiKey: dotenv.env['API_KEY'] ?? '',
      projectId: dotenv.env['PROJECT_ID'] ?? '',
      messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ?? '',
      appId: dotenv.env['APP_ID'] ?? '',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/loginPage', // change to what you are currently work on
      // change to what you are currently work on
      routes: {
        // all the routs (pages) in the app
        // '/createQuiestionPage': (context) => CreateQuestionPage(),
        '/gradingPage': (context) => GradingPage(),
        '/reportPage': (context) => ReportPage(),
        // '/takeQuizPage': (context) => TakeQuizPage(),
        // '/editQuizPage': (context) => EditQuizPage(),
        '/quizManagementPage': (context) => QuizManagementPage(),
        // '/studentResults': (context) => StudentResults(),
        '/allQuizQuestionsPage': (context) => AllQuizQuestionsPage(),
        '/signupPage': (context) => SignupPage(),
        '/allQuizesPage': (context) => AllQuizesPage(),
        '/profilePage': (context) => ProfilePage(),
        '/loginPage': (context) => LoginPage(),
        '/enterQuizIdPage': (context) => EnterQuizIdPage(),
        // '/testPage': (context) =>
        '/adminProfilePage': (context) => AdminProfilePage(),
        '/createQuizPage': (context) => CreateQuizPage(),
        '/testPage': (context) => TestPage(),
        '/allTeacherQuizzes': (context) => allTeacherQuizzes(),
        '/allStudentAttempts': (context) => AllStudentAttempts()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
