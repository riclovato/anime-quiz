import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/app_bar.dart';


class Result extends StatelessWidget {
  final int correctAnswers;

  const Result({super.key, required this.correctAnswers});
  

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
              Text("You answered correctly $correctAnswers out of 10", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('Play Again', style: TextStyle(fontSize: 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
