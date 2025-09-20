import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import '../components/app_bar.dart';

class Quiz extends StatefulWidget {
  final List<Question> questions;
  const Quiz({Key? key, required this.questions}) : super(key: key);
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int questionIndex = 1;
  int correctAnswer = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 50),
                  child: Text(
                    'Question $questionIndex of 10',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 50),
                child: Text(
                  widget.questions[questionIndex - 1].question,
                  style: TextStyle(fontSize: 30),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 80, 0, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildAnswerButton(
                      widget.questions[questionIndex - 1].options[0],
                      0,
                      widget.questions[questionIndex - 1].correctAnswerIndex,
                    ),
                    SizedBox(height: 15),
                    buildAnswerButton(
                      widget.questions[questionIndex - 1].options[1],
                      1,
                      widget.questions[questionIndex - 1].correctAnswerIndex,
                    ),
                    SizedBox(height: 15),
                    buildAnswerButton(
                      widget.questions[questionIndex - 1].options[2],
                      2,
                      widget.questions[questionIndex - 1].correctAnswerIndex,
                    ),
                    SizedBox(height: 15),
                    buildAnswerButton(
                      widget.questions[questionIndex - 1].options[3],
                      3,
                      widget.questions[questionIndex - 1].correctAnswerIndex,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnswerButton(String answerText, int number, int answerIndex) {
    Color? buttonColor;
    return StatefulBuilder(
      builder: (context, setButtonState) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setButtonState(() {
                  buttonColor = (number == answerIndex)
                      ? Colors.green
                      : Colors.red;
                });

                Future.delayed(const Duration(milliseconds: 500), () {
                  // volta a cor do botão
                  setButtonState(() {
                    buttonColor = null;
                  });

                  if (number == answerIndex) {
                    setState(() {
                      correctAnswer++;
                    });
                    print('Correct answers: $correctAnswer');
                  }

                  if (questionIndex < widget.questions.length) {
                    setState(() {
                      questionIndex++;
                    });
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/result',
                      arguments: correctAnswer,
                    );
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(answerText, style: TextStyle(fontSize: 25)),
            ),
          ),
        );
      },
    );
  }
}
