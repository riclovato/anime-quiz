import 'package:flutter/material.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Anime Quiz'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlutterLogo(size: 200),
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