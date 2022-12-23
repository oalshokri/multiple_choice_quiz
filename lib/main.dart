import 'package:flutter/material.dart';
import 'package:multiple_choice_quiz/quiz_brain.dart';
import 'package:multiple_choice_quiz/result.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade900,
                Colors.purpleAccent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: QuizPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Widget> scoreKeeper = [];
  bool showResult = false;
  int? _choice;
  int score = 0;
  late double progress;

  void checkAnswer(int userPickedAnswer) {
    int correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        quizBrain.reset();
        scoreKeeper = [];
        progress = quizBrain.getQuestionCount().toDouble();
        showResult = true;
      } else {
        progress--;
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          ));
          score += 10;
          print(score);
        } else {
          scoreKeeper.add(Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          ));
        }

        quizBrain.nextQuestion();
      }
      _choice = null;
    });
  }

  @override
  void initState() {
    progress = quizBrain.getQuestionCount().toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showResult
        ? ResultPage(score: score, fullMark: quizBrain.getQuestionCount() * 10)
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LinearProgressIndicator(
                value: progress / 5,
                minHeight: 5,
                color: Colors.purpleAccent,
                backgroundColor: Colors.purple.shade800,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            quizBrain.getQuestionChoices()[index],
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 20),
                          ),
                          leading: Radio<int>(
                            value: index,
                            groupValue: _choice,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return (_choice != null)
                                  ? Colors.yellow
                                  : Colors.amber;
                            }),
                            onChanged: (int? value) {
                              setState(() {
                                _choice = value;
                                checkAnswer(_choice!);
                              });
                            },
                          ),
                        );
                      })),
              Row(
                children: scoreKeeper,
              )
            ],
          );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
