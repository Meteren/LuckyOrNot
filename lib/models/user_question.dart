
class UserQuestion {
  final int id;
  final String question;
  final String answer;

  UserQuestion({required this.id, required this.question, required this.answer});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  @override
  String toString() {
    return 'Question{id: $id, question: $question, answer: $answer}';
  }
}

