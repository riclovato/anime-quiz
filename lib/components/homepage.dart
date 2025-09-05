import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_bar.dart';
class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
                onPressed: () {
                  print('Start button pressed');
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
