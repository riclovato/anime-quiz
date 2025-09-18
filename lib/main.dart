import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/pages/quiz.dart';
import 'package:quiz/pages/result.dart';
import 'pages/admin_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/homepage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: GoogleFonts.bangers().fontFamily,
        primaryColor: Colors.deepPurpleAccent[200],
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.indigo[400],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      routes: {
        '/': (context) => Homepage(),
        '/quiz': (context) => Quiz(
          questions:
              ModalRoute.of(context)!.settings.arguments as List<Question>,
        ),
        '/admin': (context) => AdminPage(),
        '/result': (context) => Result(
          correctAnswers: ModalRoute.of(context)!.settings.arguments as int,
        ),
      },
    );
  }
}
