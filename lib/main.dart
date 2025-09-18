import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/pages/quiz.dart';
import 'pages/admin_page.dart';

import 'pages/homepage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => Homepage(),
        '/quiz':(context) => Quiz(questions: ModalRoute.of(context)!.settings.arguments as List<Question>),
        '/admin':(context) => AdminPage(),
      },
    );
  }
}
