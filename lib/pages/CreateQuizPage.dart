<<<<<<< HEAD
=======
import 'package:flutter/material.dart';

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
            Text('Creat a new qize.',
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
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController _startDateTimeController = TextEditingController();
  TextEditingController _endDateTimeController = TextEditingController();

  DateTime? _startDateTime;
  DateTime? _endDateTime;

  void _createQuiz() {
    final quiz = {
      'questionText': _questionController.text,
      'description': _descriptionController.text,
      'startDateTime': _startDateTime?.toIso8601String(),
      'endDateTime': _endDateTime?.toIso8601String(),
    };

    print('Quiz Created: $quiz');

    // Clear inputs
    _questionController.clear();
    _descriptionController.clear();
    _startDateTimeController.clear();
    _endDateTimeController.clear();
    _startDateTime = null;
    _endDateTime = null;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question Title'),
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
              onPressed: _createQuiz,
              child: Text('Create Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> 8d68f8ebffcf951013d1af188af4d59c13a757f1
