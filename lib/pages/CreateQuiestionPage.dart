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

class CreateQuiestionPage extends StatefulWidget {
  const CreateQuiestionPage({super.key});

  @override
  State<CreateQuiestionPage> createState() => _CreateQuiestionPageState();
}

class _CreateQuiestionPageState extends State<CreateQuiestionPage> {
  String quiestionType = Question.allQuestionTypes[0]['value'];
  int selectedIndex = 0;
  int seletedQuestionIndex = 0;

  TextEditingController writtenCorrectAnswerController =
      TextEditingController();

  late TextEditingController question_text_controller; // Declare the controller
  late Quiz quiz; // Declare the quiz object

  @override
  void initState() {
    super.initState();
    // Initialize quiz and controller
    quiz = placeHolderQuizzes.quiz1;
    question_text_controller = TextEditingController(
      text: quiz.questions[seletedQuestionIndex].question_text,
    );
  }

  void saveCurrentEditedQuestion() {
    quiz.questions[seletedQuestionIndex].question_text =
        question_text_controller.text;
    switch (quiz.questions[seletedQuestionIndex].question_type) {
      case 'TF':
        break;
      case 'MCQ':
        break;

      case 'WRITTEN':
        quiz.questions[seletedQuestionIndex].writtenCorrectAnswer =
            writtenCorrectAnswerController.value.text;

        break;
    }

    setState(() {});
  }

  void changeCurrentEditedQuestion(int index) {
    writtenCorrectAnswerController.text =
        quiz.questions[index].writtenCorrectAnswer ?? "";
    question_text_controller.text = quiz.questions[index].question_text;
    seletedQuestionIndex = index; // Update the selected question index

    setState(() {});
  }

  // void changeQuestionType(String newType){
  //   quiz.questions[seletedQuestionIndex].question_type = ;
  // }

  @override
  void dispose() {
    question_text_controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getListOfQuestions() {
      List<Widget> temp = quiz.questions
          .asMap()
          .map((index, question) =>
              MapEntry(index, Container(child: Text((index + 1).toString()))))
          .values
          .toList();

      temp.add(Container(child: Icon(Icons.add)));

      return temp;
    }

    List<Widget> listOfQuestions = getListOfQuestions();

    return Scaffold(
      bottomNavigationBar: AdminCustom(),
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ToggleButtons(
                children: listOfQuestions,
                isSelected: listOfQuestions.map<bool>((_) => false).toList(),
                onPressed: (index) {
                  changeCurrentEditedQuestion(index);
                }),
            Text(
              'Quiestion type',
              style: TextStyle(fontSize: 16),
            ),
            Column(
              children: Question.allQuestionTypes
                  .map((e) => RadioListTile(
                        value: e['value'],
                        title: Text(e['title']),
                        groupValue:
                            quiz.questions[seletedQuestionIndex].question_type,
                        onChanged: (v) {
                          if (v != null) {
                            setState(() {
                              quiz.questions[seletedQuestionIndex]
                                  .question_type = v;
                            });
                          }
                        },
                      ))
                  .toList(),
            ),
            TextField(
              controller: question_text_controller,
              decoration: InputDecoration(
                labelText: 'Write the question',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                quiz.questions[seletedQuestionIndex].question_text = value;
              },
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: VerticalDivider()),
            'TF' == quiz.questions[seletedQuestionIndex].question_type
                ? TrueFalse(
                    selectedAnswer:
                        quiz.questions[seletedQuestionIndex].tfSelectedAnswer ??
                            false,
                    onAnswerChanged: (newTFAnswer) {
                      quiz.questions[seletedQuestionIndex].tfSelectedAnswer =
                          newTFAnswer;
                    })
                : SizedBox(),
            'MCQ' == quiz.questions[seletedQuestionIndex].question_type
                ? MCQ()
                : SizedBox(),
            'WRITTEN' == quiz.questions[seletedQuestionIndex].question_type
                ? Written(
                    controller: writtenCorrectAnswerController,
                  )
                : SizedBox(),
            ElevatedButton(
                onPressed: saveCurrentEditedQuestion,
                child: Text('save question')),
            ElevatedButton(onPressed: () {}, child: Text('finish')),
          ],
        ),
      ),
    );
  }
}
