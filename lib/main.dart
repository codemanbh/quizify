import 'package:flutter/material.dart';
import 'pages/CreateQuiestionPage.dart';
import './pages/GradingPage.dart';
import './pages/CreateQuiestionPage.dart';
import './pages/ReportPage.dart';
import './pages/EditQuizPage.dart';
import './pages/QuizManagementPage.dart';
import './pages/StudentResults.dart';
import './pages/TakeQuizPage.dart';
import './pages/AllQuizQuestionsPage.dart';
import './pages/SignupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/CreateQuiestionPage',
      routes: {
        '/CreateQuiestionPage': (context) => CreateQuiestionPage(),
        '/GradingPage': (context) => GradingPage(),
        '/ReportPage': (context) => ReportPage(),
        '/TakeQuizPage': (context) => TakeQuizPage(),
        '/EditQuizPage': (context) => EditQuizPage(),
        '/QuizManagementPage': (context) => QuizManagementPage(),
        '/StudentResults': (context) => StudentResults(),
        '/AllQuizQuestionsPage': (context) => AllQuizQuestionsPage(),
        '/SignupPage': (context) => SignupPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}
