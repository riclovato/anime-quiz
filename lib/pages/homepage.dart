import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import 'package:quiz/services/question_service.dart';
import 'package:quiz/models/question.dart';

class Homepage extends StatelessWidget {
  final QuestionService _questionService = QuestionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 100,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              child: Image.asset('images/logo.png', width: 300, height: 300),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                List<Question> questions = (await _questionService
                    .getRandomQuestions(limit: 10));

                Navigator.pushNamed(context, '/quiz', arguments: questions);
              },
              style:
                  ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 20,
                    shadowColor: Colors.white.withValues(alpha: 0.8),
                    backgroundColor: Colors.deepPurpleAccent,
                  ).merge(
                    ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Colors.deepPurpleAccent.shade100.withValues(alpha: 150),
                      ),
                    ),
                  ),
              child: const Text('Start', style: TextStyle(fontSize: 50)),
            ),
          ],
        ),
      ),
    );
  }
}
