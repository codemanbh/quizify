class Question {
  String id = '';
  String question_type = "";
  String question_text = "";
  List<String> possible_answers = [];
  List<String> correct_answer = [];
  double grade = 0;
  bool isRequired = false;

  Map<String, dynamic> mcqToMap() {
    return {
      "id": id,
      "question_type": question_type,
      "question_text": question_text,
      "possible_answers": possible_answers,
      "correct_answer": correct_answer,
      "grade": grade,
      "isRequired": isRequired,
    };
  }

  Map<String, dynamic> trueFalseToMap() {
    return {
      "id": id,
      "question_type": question_type,
      "question_text": question_text,
      "correct_answer": correct_answer, // "True" or "False"
      "grade": grade,
      "isRequired": isRequired,
    };
  }

  Map<String, dynamic> writtenToMap() {
    return {
      "id": id,
      "question_type": question_type,
      "question_text": question_text,
      "grade": grade,
      "isRequired": isRequired,
    };
  }

  /// A unified save function that determines which specific save function to call
  Map<String, dynamic> questionToMap() {
    switch (question_type) {
      case "MCQ":
        return mcqToMap();
      case "TF":
        return trueFalseToMap();
      case "WRITTEN":
        return writtenToMap();
      default:
        throw Exception("Unsupported question type: $question_type");
    }
  }

  static List<Map<dynamic, dynamic>> allQuestionTypes = [
    {"title": 'True/False', "value": "TF"},
    {"title": 'MCQ', "value": "MCQ"},
    {"title": "WRITTEN", "value": 'WRITTEN'}
  ];

  static List<Map<dynamic, dynamic>> trueFalseValues = [
    {"title": 'True', "value": true},
    {"title": 'False', "value": false},
  ];
}
