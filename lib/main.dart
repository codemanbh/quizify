import 'package:flutter/material.dart';
import './pages/CreateQuizPage.dart';
import './pages/GradingPage.dart';
import './pages/CreateQuizPage.dart';
import './pages/ReportPage.dart';
import './pages/EditQuizPage.dart';
import './pages/QuizManagementPage.dart';
import './pages/StudentResults.dart';
import './pages/TakeQuizPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/createQuizPage',
      routes: {
        '/createQuizPage': (context) => CreateQuizPage(),
        '/GradingPage': (context) => GradingPage(),
        '/ReportPage': (context) => ReportPage(),
        '/TakeQuizPage': (context) => TakeQuizPage(),
        '/EditQuizPage': (context) => EditQuizPage(),
        '/QuizManagementPage': (context) => QuizManagementPage(),
        '/StudentResults': (context) => StudentResults(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
          Center(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
