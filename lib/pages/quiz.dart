import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import '../components/app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  final List<Question> questions;
  const Quiz({Key? key, required this.questions}) : super(key: key);
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int questionIndex = 1;
  @override
  Widget build(BuildContext context) {
  
    
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.bangers().fontFamily,
        primaryColor: Colors.deepPurpleAccent[200],
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.indigo[400],
      ),
      home: Scaffold(
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
                      buildAnswerButton(widget.questions[questionIndex - 1].options[0], 0),
                      SizedBox(height: 15),
                      buildAnswerButton(widget.questions[questionIndex - 1].options[1], 1),
                      SizedBox(height: 15),
                      buildAnswerButton(widget.questions[questionIndex - 1].options[2], 2),
                      SizedBox(height: 15),
                      buildAnswerButton(widget.questions[questionIndex - 1].options[3], 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAnswerButton(String answerText, int number) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
             print('Answer $number button pressed');
            setState(() {
              if (questionIndex <= widget.questions.length - 1) {
                questionIndex++; 
              } else {
                print("Quiz finished!");
              }
            });
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(answerText, style: TextStyle(fontSize: 25)),
        ),
      ),
    );
  }
}
