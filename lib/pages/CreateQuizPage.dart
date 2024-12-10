import 'package:flutter/material.dart';
import '../models/Quiz.dart';
import '../components/AdminCustomNavBar.dart';
import '../pages/CreateQuestionPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateQuizPage()),
                );
              },
              child: Text('Create Quiz'),
            ),
            SizedBox(height: 10),
            Text('Creat a new Quiz',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text('Take Quiz'),
            ),
            SizedBox(height: 10),
            Text('Please, dear student, do not try to cheat.',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

class CreateQuizPage extends StatefulWidget {
  @override
  _CreateQuizPageState createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController _startDateTimeController = TextEditingController();
  TextEditingController _endDateTimeController = TextEditingController();

  DateTime? _startDateTime;
  DateTime? _endDateTime;

  void goToCreateQuestionPage() {
    // final quiz = {
    //   'questionText': _questionController.value.text,
    //   'description': _descriptionController.value.text, // TODO: make the get date logic
    // 'startDateTime': _startDateTimeController.value?..toIso8601String(),
    // 'endDateTime': _endDateTime?.toIso8601String(),
    // };

    Quiz quiz = Quiz();
    quiz.title = _titleController.value.text;
    quiz.description = _descriptionController.value.text;
    quiz.start_date = _startDateTime;
    quiz.end_date = _endDateTime;

    // print('Quiz Created: $quiz');

    // Clear inputs
    // _questionController.clear();
    // _descriptionController.clear();
    // _startDateTimeController.clear();
    // _endDateTimeController.clear();
    // _startDateTime = null;
    // _endDateTime = null;

    // Navigator.of(context).pushReplacementNamed('/createQuiestionPage',
    //     arguments: {'quiz': quiz});

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CreateQuestionPage(quiz: quiz),
      ),
    );
    // Navigator.pushReplacement((context) => CreateQuestionPage());
    // CreateQuestionPage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Quiz created successfully!')),
    );
  }

  Future<void> _selectStartDateTime() async {
    // Select Date
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      // Select Time
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        // Combine date and time into DateTime object
        _startDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Update the controller with formatted string
        _startDateTimeController.text = _startDateTime!.toLocal().toString();
      }
    }
  }

  Future<void> _selectEndDateTime() async {
    // Select Date
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      // Select Time
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        // Combine date and time into DateTime object
        _endDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Update the controller with formatted string
        _endDateTimeController.text = _endDateTime!.toLocal().toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      bottomNavigationBar: AdminCustomNavBar(
        page_url: '/createQuizPage',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Quiz Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            Text(
              'Select Start Date and Time:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _startDateTimeController,
              readOnly: true,
              onTap: _selectStartDateTime,
              decoration:
                  InputDecoration(hintText: 'Select a start date and time'),
            ),
            SizedBox(height: 20),
            Text(
              'Select End Date and Time:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _endDateTimeController,
              readOnly: true,
              onTap: _selectEndDateTime,
              decoration:
                  InputDecoration(hintText: 'Select an end date and time'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: goToCreateQuestionPage,
              child: Text('Create Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
