import 'package:flutter/material.dart';
import 'package:quizify/components/AdminCustomNavBar.dart';
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
  final Quiz quiz;
  const CreateQuestionPage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  late Quiz quiz;
  int selectedQuestionIndex = 0;
  bool firstTime = true;
  late TextEditingController questionTextController;
  late TextEditingController teacherCorrectAnswerController;
  late TextEditingController question;

  ValueNotifier<String> teacherMcqCorrectAnswerController =
      ValueNotifier<String>('');
  List<bool> isSelected = [];

  final ValueNotifier<List<String>> mcqCurrentPossibleAnswers =
      ValueNotifier<List<String>>(["Item 1", "Item 2", "Item 3"]);

  @override
  void initState() {
    super.initState();
    quiz = widget.quiz;
    // quiz = placeHolderQuizzes.quiz1;
    // quiz = Quiz();
    if (quiz.questions.length == 0) {
      quiz.questions.add(Question());
    }
    // quiz.questions.add(Question());

    questionTextController = TextEditingController(
      text: quiz.questions[selectedQuestionIndex].question_text,
    );

    teacherCorrectAnswerController = TextEditingController(
        // text: quiz.questions[selectedQuestionIndex].writtenCorrectAnswer ?? '',
        );

    isSelected = List.generate(quiz.questions.length + 1, (index) => false);
    isSelected[selectedQuestionIndex] = true;
    mcqCurrentPossibleAnswers.value =
        List.from(quiz.questions[selectedQuestionIndex].possibleMcqAnswers);
  }

  void saveCurrentEditedQuestion() {
    quiz.questions[selectedQuestionIndex].question_text =
        questionTextController.text;
    if (quiz.questions[selectedQuestionIndex].question_type == 'WRITTEN') {
      quiz.questions[selectedQuestionIndex].teacherCorrectAnswer =
          teacherCorrectAnswerController.text;
    }
  }

  void changeCurrentEditedQuestion(int index) {
    if (index == quiz.questions.length) {
      // Add a new question
      quiz.questions.add(Question()
        ..questionID = DateTime.now().millisecondsSinceEpoch.toString()
        ..question_type = 'WRITTEN');
    }

    if (quiz.questions[selectedQuestionIndex].question_type == 'MCQ') {
      quiz.questions[selectedQuestionIndex].possibleMcqAnswers =
          List.from(mcqCurrentPossibleAnswers.value);

      quiz.questions[selectedQuestionIndex].teacherCorrectAnswer =
          teacherMcqCorrectAnswerController.value;
    }

    selectedQuestionIndex = index;

    teacherMcqCorrectAnswerController.value =
        quiz.questions[selectedQuestionIndex].teacherCorrectAnswer ?? '';

    mcqCurrentPossibleAnswers.value =
        List.from(quiz.questions[selectedQuestionIndex].possibleMcqAnswers);
    questionTextController.text =
        quiz.questions[selectedQuestionIndex].question_text;

    teacherCorrectAnswerController.text =
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
    if (firstTime) {
      // Retrieve the passed arguments and check if they contain the 'quiz' key

      if (quiz == null) {
        // Handle the case where the quiz is null or not passed correctly.
        return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text('No quiz data passed')),
        );
      }
    }
    firstTime = false;
    return Scaffold(
      bottomNavigationBar: AdminCustomNavBar(
        page_url: '/createQuestionPage',
      ),
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                        // question_type
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

                            // print(quiz
                            //     .questions[selectedQuestionIndex].question_type);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
              TextField(
                // question Text feaild
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
                    quiz.questions[selectedQuestionIndex].teacherCorrectAnswer =
                        newTFAnswer;
                    setState(() {});
                  },
                ),
              if ('MCQ' == quiz.questions[selectedQuestionIndex].question_type)
                MCQ(
                  possibleMcqAnswers: mcqCurrentPossibleAnswers,
                  teacherCorrectAnswerController:
                      teacherMcqCorrectAnswerController,
                  onChange:
                      (List<String> updatedAnswers, String correctAnswer) {
                    print(updatedAnswers);
                    print(correctAnswer);
                    mcqCurrentPossibleAnswers.value = List.from(updatedAnswers);
                    setState(() {});

                    // print('Updated answers: ${quiz.questions[selectedQuestionIndex].possibleMcqAnswers}');
                    // print('Correct answer: ${teacherCorrectAnswerController.value}');
                  },
                ),
              if ('WRITTEN' ==
                  quiz.questions[selectedQuestionIndex].question_type)
                Written(controller: teacherCorrectAnswerController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveCurrentEditedQuestion,
                child: const Text('Save Question'),
              ),
              ElevatedButton(
                onPressed: () {
                  saveCurrentEditedQuestion();
                  print('saved');
                  // Add logic to finalize the quiz creation

                  quiz.submitQuizTeacher();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Quiz created successfully!')),
                  );
                },
                child: const Text('Finish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
