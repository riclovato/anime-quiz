import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
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
                      'Question 1 of 10',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 50),
                  child: Text(
                    'What is the name of the protagonist of Naruto?',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
          
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 80, 0, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildAnswerButton("Answer 1", 1),
                      SizedBox(height: 15,),
                      buildAnswerButton("Answer 2", 2),
                       SizedBox(height: 15,),
                      buildAnswerButton("Answer 3", 3),
                       SizedBox(height: 15,),
                      buildAnswerButton("Answer 4", 4),
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
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20 ),
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
