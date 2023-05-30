
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
