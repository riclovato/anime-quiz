import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/pages/quiz.dart';
import '../components/app_bar.dart';
import 'package:quiz/services/question_service.dart';
import 'package:quiz/models/question.dart';

class Homepage extends StatelessWidget {
  final QuestionService _questionService = QuestionService();

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //FlutterLogo(size: 200),
              Image.asset('images/logo.png', width: 300, height: 300),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  List<Question> questions = (await _questionService
                      .getRandomQuestions(limit: 10));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Quiz(questions: questions),
                    ),
                  );
                },
                child: const Text('Start', style: TextStyle(fontSize: 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
