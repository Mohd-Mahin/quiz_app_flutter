import "package:flutter/material.dart";
import "package:quiz_app/question_bank.dart";
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MaterialApp(home: Home()));

QuestionBank questionBank = QuestionBank();

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Quiz(),
        ),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Icon> answersIcons = [];

  checkAnswer(bool answerType) {
    bool correctAns = questionBank.getAnswer();
    if (questionBank.isLastIndex()) {
      Alert(
          context: context,
          title: "Game End",
          desc: "You are on last question of quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
              color: Colors.red,
            )
          ]).show();
      return;
    }

    if (correctAns == answerType) {
      answersIcons.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else
      answersIcons.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                questionBank.getQuestion(),
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    checkAnswer(true);
                    questionBank.increment();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'True',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      checkAnswer(false);
                      questionBank.increment();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "False",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: answersIcons,
        )
      ],
    );
  }
}
