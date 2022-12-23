class Question {
  String questionText;
  Answer questionAnswer;
  List<String> choices;

  Question(this.questionText, this.questionAnswer, this.choices);
}

enum Answer { A, B, C, D }
