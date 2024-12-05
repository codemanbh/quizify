import 'package:flutter/material.dart';
import 'package:quizify/components/Written.dart';
import '../../models/Question.dart';
import '../../components/TrueFalse.dart';
import '../../components/MCQ.dart';
import '../../components/MCQ.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CreateQuiestionPage extends StatefulWidget {
  const CreateQuiestionPage({super.key});

  @override
  State<CreateQuiestionPage> createState() => _CreateQuiestionPageState();
}

class _CreateQuiestionPageState extends State<CreateQuiestionPage> {
  String quiestionType = Question.allQuiestionTypes[0]['value'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add question'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Quiestion type',
              style: TextStyle(fontSize: 16),
            ),
            Column(
              children: Question.allQuiestionTypes
                  .map((e) => RadioListTile(
                        value: e['value'],
                        title: Text(e['title']),
                        groupValue: quiestionType,
                        onChanged: (v) {
                          if (v != null) {
                            quiestionType = v;
                            setState(() {});
                          }
                        },
                      ))
                  .toList(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Write the question',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print('Current text: $value');
              },
            ),

            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: VerticalDivider()),

            'TF' == quiestionType ? TrueFalse() : SizedBox(),
            'MCQ' == quiestionType ? MCQ() : SizedBox(),
            'WRITTEN' == quiestionType ? Written() : SizedBox(),
            ElevatedButton(onPressed: () {}, child: Text('Add the question')),
            // Text('asdsa')
          ],
        ),
      ),
    );
  }
}
