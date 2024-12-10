import './Question.dart';
import './Quiz.dart';

class placeHolderQuizzes {
  // First Quiz: "Cat Basics"
  static Quiz quiz1 = Quiz()
    ..quizID = "1"
    ..title = "Cat Basics"
    ..description = "Test your basic knowledge about cats."
    ..start_date = DateTime.now()
    ..end_date = DateTime.now().add(Duration(days: 7))
    ..questions = [
      Question()
        ..questionID = "1"
        ..quizId = "1"
        ..question_type = "MCQ"
        ..question_text = "What is the average lifespan of a domestic cat?"
        ..possibleMcqAnswers = [
          "5-7 years",
          "10-15 years",
          "20-25 years",
          "30+ years"
        ]
        ..studentSelectedAnswer = "10-15 years"
        ..teacherCorrectAnswer = "10-15 years"
        ..questionGrade = 5
        ..studentGrade = 0, // Default value
      Question()
        ..questionID = "2"
        ..quizId = "1"
        ..question_type = "TF"
        ..question_text = "Cats can purr only when they're happy."
        ..teacherCorrectAnswer = 'false'
        ..studentSelectedAnswer = 'true'
        ..questionGrade = 3
        ..studentGrade = 0, // Default value
    ];

  // Second Quiz: "Feline Fun Facts"
  static Quiz quiz2 = Quiz()
    ..quizID = "2"
    ..title = "Feline Fun Facts"
    ..description = "Learn some fun facts about cats."
    ..start_date = DateTime.now()
    ..end_date = DateTime.now().add(Duration(days: 7))
    ..questions = [
      Question()
        ..questionID = "1"
        ..quizId = "2"
        ..question_type = "MCQ"
        ..question_text = "Which breed of cat is known for being hairless?"
        ..possibleMcqAnswers = ["Sphynx", "Persian", "Maine Coon", "Ragdoll"]
        ..teacherCorrectAnswer = "Sphynx"
        ..questionGrade = 5
        ..studentGrade = 0, // Default value
      Question()
        ..questionID = "2"
        ..quizId = "2"
        ..question_type = "WRITTEN"
        ..question_text = "Describe why cats often land on their feet."
        ..teacherCorrectAnswer = "Cats use their righting reflex."
        ..questionGrade = 10
        ..studentGrade = 0, // Default value
    ];

  // Third Quiz: "Advanced Cat Trivia" (New Quiz)
  static Quiz quiz3 = Quiz()
    ..quizID = "3"
    ..title = "Advanced Cat Trivia"
    ..description = "Challenge yourself with advanced trivia about cats."
    ..start_date = DateTime.now()
    ..end_date = DateTime.now().add(Duration(days: 10))
    ..questions = [
      Question()
        ..questionID = "1"
        ..quizId = "3"
        ..question_type = "MCQ"
        ..question_text = "What is the scientific name for the domestic cat?"
        ..possibleMcqAnswers = [
          "Felis catus",
          "Canis lupus",
          "Panthera leo",
          "Lynx lynx"
        ]
        ..teacherCorrectAnswer = "Felis catus"
        ..questionGrade = 7
        ..studentGrade = 0, // Default value
      Question()
        ..questionID = "2"
        ..quizId = "3"
        ..question_type = "TF"
        ..question_text = "Cats are obligate carnivores."
        ..teacherCorrectAnswer = 'true'
        ..questionGrade = 5
        ..studentGrade = 0, // Default value
      Question()
        ..questionID = "3"
        ..quizId = "3"
        ..question_type = "WRITTEN"
        ..question_text = "Explain how cats communicate with humans."
        ..teacherCorrectAnswer =
            "Cats communicate using vocalizations, body language, and behavior."
        ..questionGrade = 8
        ..studentGrade = 0, // Default value
    ];
}
