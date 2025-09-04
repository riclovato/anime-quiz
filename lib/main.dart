import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Homepage());
}

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
        appBar: AppBar(
          title: Center(child: const Text('Anime Quiz')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //FlutterLogo(size: 200),
              Image.asset('images/logo.png', width: 600, height: 600),
              ElevatedButton(
                onPressed: () {
                  print('Start button pressed');
                },
                child: const Text('Start'),
              ),
            ],
          ),
        ),

      ),
    );
  }
}