import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/pages/login_page.dart';
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
        scaffoldBackgroundColor: Colors.transparent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:
              ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 15,
                backgroundColor: Colors.deepPurpleAccent,
              ).merge(
                ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(
                    Colors.deepPurpleAccent.shade100.withValues(alpha: 150),
                  ),
                ),
              ),
        ),
      ),

      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFA8C0FF), // topo - azul clarinho / lavanda
                Color(0xFF7B67D4), // meio - lavanda/índigo
                Color(0xFF2B0B3D), // base - roxo bem escuro
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      routes: {
        '/login': (context) => const LoginPage(),
        '/admin': (context) => const AdminPage(),
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
