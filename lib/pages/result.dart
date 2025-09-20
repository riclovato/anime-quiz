import 'package:flutter/material.dart';
import '../components/app_bar.dart';


class Result extends StatelessWidget {
  final int correctAnswers;

  const Result({super.key, required this.correctAnswers});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              Text("You answered correctly $correctAnswers out of 10", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                
                  Navigator.pushReplacementNamed(context, '/');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 20,
                  shadowColor: Colors.white.withValues(alpha: 0.8),
                  backgroundColor: Colors.deepPurpleAccent,
                ).merge(
                  ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.deepPurpleAccent.shade100.withValues(alpha: 150))),
                ),
                child: const Text('Play Again', style: TextStyle(fontSize: 50)),
              ),
            ],
          ),
        ),
      );
  }
}
