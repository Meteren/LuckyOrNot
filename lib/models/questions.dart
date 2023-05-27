import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class Question {
  String questionText;
  bool questionAnswer;
  Question(this.questionText, this.questionAnswer);

  Question.fromMap(Map<String, dynamic> m) : this(
    m['question'],m['answer']
  );

  Map toMap(){
    return {
      'question': questionText,
      'answer': questionAnswer,
    };
  }
}

class QuizBrain {
  int questionNumber = 0;
  List<Question> questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('Lions are one of the oldest living species', false),
  ];

  void download(QuizBrain obj) async{
    final baseUrl = 'https://64656bb79c09d77a62ebdbf2.mockapi.io/';
    final response = await http
        .get(Uri.parse('$baseUrl/questions'));

    final data = jsonDecode(response.body);

    for (int i = 1; i <= data.length; i++) {
      Question question = await fetchQuestion(i);
      obj.questionBank.add(question);
    }
  }

  void removeQuestion(QuizBrain obj){
    obj.questionBank.removeAt(obj.questionNumber);
  }

  String getQuestionText(QuizBrain obj) {
    return obj.questionBank[obj.questionNumber].questionText;
  }

  void RandomQuestion(QuizBrain obj) {
    obj.questionNumber  = Random().nextInt(obj.questionBank.length);
  }

  bool getCorrectAnswer(QuizBrain obj) {
    return obj.questionBank[obj.questionNumber].questionAnswer;
  }
}

Future<Question> fetchQuestion(int i) async {
  final baseUrl = 'https://64656bb79c09d77a62ebdbf2.mockapi.io/';
  final response = await http
      .get(Uri.parse('$baseUrl/questions/$i'));

  if (response.statusCode == 200) {
    return Question.fromMap(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load questions ${response.statusCode}');
  }
}

Future addQuestion(Question question) async{
  final baseUrl = 'https://64656bb79c09d77a62ebdbf2.mockapi.io/';
   final response = await http.post(
     Uri.parse('$baseUrl/questions'),
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
     },
     body: jsonEncode(question.toMap()),
   );
  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to upload question ${response.statusCode}');
  }

}