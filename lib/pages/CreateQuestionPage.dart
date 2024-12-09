import 'package:flutter/material.dart';
import 'package:quizify/components/AdminCustom.dart';
import 'package:quizify/components/Written.dart';
import '../../models/Question.dart';
import '../../components/TrueFalse.dart';
import '../../components/MCQ.dart';
import '../../components/MCQ.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../components/CustomNavBar.dart';
import '../models/Quiz.dart';
import '../models/placehilderQuizes.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({super.key});

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  late Quiz quiz;
  int selectedQuestionIndex = 0;

  late TextEditingController questionTextController;
  late TextEditingController teacherCorrectAnswerController;

  List<bool> isSelected = [];

  @override
  void initState() {
    super.initState();
    quiz = placeHolderQuizzes.quiz1;

    questionTextController = TextEditingController(
      text: quiz.questions[selectedQuestionIndex].question_text,
    );

    teacherCorrectAnswerController = TextEditingController(
        // text: quiz.questions[selectedQuestionIndex].writtenCorrectAnswer ?? '',
        );

    isSelected = List.generate(quiz.questions.length + 1, (index) => false);
    isSelected[selectedQuestionIndex] = true;
  }

  void saveCurrentEditedQuestion() {
    quiz.questions[selectedQuestionIndex].question_text =
        questionTextController.text;

    switch (quiz.questions[selectedQuestionIndex].question_type) {
      case 'TF':
        // Save True/False specific data if necessary
        break;

      case 'MCQ':
        // Save MCQ-specific data if necessary
        break;

      case 'WRITTEN':
        quiz.questions[selectedQuestionIndex].writtenCorrectAnswer =
            writtenCorrectAnswerController.text;
        break;
    }

    setState(() {});
  }

  void changeCurrentEditedQuestion(int index) {
    saveCurrentEditedQuestion();

    if (index == quiz.questions.length) {
      // Add a new question
      quiz.questions.add(Question()
        ..questionID = DateTime.now().millisecondsSinceEpoch.toString()
        ..question_type = 'WRITTEN');
    }

    selectedQuestionIndex = index;

    questionTextController.text =
        quiz.questions[selectedQuestionIndex].question_text;

    writtenCorrectAnswerController.text =
        quiz.questions[selectedQuestionIndex].teacherCorrectAnswer ?? '';

    isSelected = List.generate(quiz.questions.length + 1, (i) => i == index);
    setState(() {});
  }

  List<Widget> getListOfQuestions() {
    return quiz.questions
        .asMap()
        .map(
          (index, question) => MapEntry(
            index,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text((index + 1).toString()),
            ),
          ),
        )
        .values
        .toList()
      ..add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.add),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AdminCustom(),
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ToggleButtons(
              children: getListOfQuestions(),
              isSelected: isSelected,
              onPressed: changeCurrentEditedQuestion,
            ),
            const SizedBox(height: 10),
            const Text(
              'Question Type',
              style: TextStyle(fontSize: 16),
            ),
            Column(
              children: Question.allQuestionTypes
                  .map(
                    (e) => RadioListTile(
                      value: e['value'],
                      title: Text(e['title']),
                      groupValue:
                          quiz.questions[selectedQuestionIndex].question_type,
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            quiz.questions[selectedQuestionIndex]
                                .question_type = v;
                          });
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
            TextField(
              controller: questionTextController,
              decoration: const InputDecoration(
                labelText: 'Write the question',
                border: OutlineInputBorder(),
              ),
            ),
            const Divider(height: 20, thickness: 1),
            if ('TF' == quiz.questions[selectedQuestionIndex].question_type)
              TrueFalse(
                selectedAnswer: quiz.questions[selectedQuestionIndex]
                        .teacherCorrectAnswer ??
                    '',
                onAnswerChanged: (newTFAnswer) {
                  quiz.questions[selectedQuestionIndex].tfCorrectAnswer =
                      newTFAnswer;
                },
              ),
            if ('MCQ' == quiz.questions[selectedQuestionIndex].question_type)
              MCQ(),
            if ('WRITTEN' ==
                quiz.questions[selectedQuestionIndex].question_type)
              Written(controller: writtenCorrectAnswerController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveCurrentEditedQuestion,
              child: const Text('Save Question'),
            ),
            ElevatedButton(
              onPressed: () {
                saveCurrentEditedQuestion();
                // Add logic to finalize the quiz creation
              },
              child: const Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
