import 'package:multiple_choice_quiz/question.dart';

class QuizBrain {
  int _qNum = 0;

  final List<Question> _questions = [
    Question(
      'Which of these EU countries does not use the euro as its currency?',
      Answer.D,
      ['Poland', 'Denmark', 'Sweden', 'All of the above'],
    ),
    Question(
      'What element does the chemical symbol Au stand for?',
      Answer.D,
      ['Silver', 'Magnesium', 'Salt', 'Gold'],
    ),
    Question(
      'On average, how many seeds are located on the outside of a strawberry?',
      Answer.B,
      ['100', '200', '400', '500'],
    ),
    Question(
      'What is the highest-grossing holiday movie of all time?',
      Answer.D,
      ['Elf', 'Die Hard', ' It’s A Wonderful Life', 'Home Alone'],
    ),
    Question(
      'What is the only food that cannot go bad?',
      Answer.C,
      ['Dark chocolate', 'Peanut butter', 'Honey', 'Canned tuna'],
    ),
  ];

  void nextQuestion() {
    if (_qNum < _questions.length - 1) {
      _qNum++;
    }
  }

  String getQuestionText() {
    return _questions[_qNum].questionText;
  }

  int getQuestionAnswer() {
    return _questions[_qNum].questionAnswer.index;
  }

  List<String> getQuestionChoices() {
    return _questions[_qNum].choices;
  }

  bool isFinished() {
    if (_qNum >= _questions.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _qNum = 0;
  }

  int getQuestionCount() {
    return _questions.length;
  }
}
