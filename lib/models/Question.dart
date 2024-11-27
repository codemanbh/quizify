class Question {
  String id = '';
  String question_type = "";
  String question_text = "";
  List<String> possible_answers = [];
  List<String> correct_answer = [];
  double grade = 0;
  bool isRequired = false;

  static List<Map<dynamic, dynamic>> allQuiestionTypes = [
    {"title": 'True/False', "value": "TF"},
    {"title": 'MCQ', "value": "MCQ"},
    {"title": "WRITTEN", "value": 'WRITTEN'}
  ];

  static List<Map<dynamic, dynamic>> TrueFalseValues = [
    {"title": 'True', "value": true},
    {"title": 'False', "value": false},
  ];
}
