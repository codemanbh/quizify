import './Question.dart';
import './Quiz.dart';

class placeHolderQuizes {
  // First Quiz: "Cat Basics"
  static Quiz quiz1 = Quiz()
    ..id = "1"
    ..title = "Cat Basics"
    ..description = "Test your basic knowledge about cats."
    ..start_date = DateTime.now()
    ..end_date = DateTime.now().add(Duration(days: 7))
    ..questions = [
      Question()
        ..id = "1"
        ..question_type = "MCQ"
        ..question_text = "What is the average lifespan of a domestic cat?"
        ..possible_answers = [
          "5-7 years",
          "10-15 years",
          "20-25 years",
          "30+ years"
        ]
        ..correct_answer = ["10-15 years"]
        ..grade = 5
        ..isRequired = true,
      Question()
        ..id = "2"
        ..question_type = "TF"
        ..question_text = "Cats can purr only when they're happy."
        ..correct_answer = ["False"]
        ..grade = 3
        ..isRequired = true,
    ];

  // Second Quiz: "Feline Fun Facts"
  static Quiz quiz2 = Quiz()
    ..id = "2"
    ..title = "Feline Fun Facts"
    ..description = "Learn some fun facts about cats."
    ..start_date = DateTime.now()
    ..end_date = DateTime.now().add(Duration(days: 7))
    ..questions = [
      Question()
        ..id = "1"
        ..question_type = "MCQ"
        ..question_text = "Which breed of cat is known for being hairless?"
        ..possible_answers = ["Sphynx", "Persian", "Maine Coon", "Ragdoll"]
        ..correct_answer = ["Sphynx"]
        ..grade = 5
        ..isRequired = true,
      Question()
        ..id = "2"
        ..question_type = "WRITTEN"
        ..question_text = "Describe why cats often land on their feet."
        ..grade = 10
        ..isRequired = false,
    ];

  // Convert quizzes to map (optional step to visualize the structure)
  // print(quiz1.quizToMap());
}
  // print(quiz2.quizToMap());