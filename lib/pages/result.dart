import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../components/app_bar.dart';

class Result extends StatefulWidget {
  final int correctAnswers;

  const Result({super.key, required this.correctAnswers});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    if (widget.correctAnswers >= 10) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.correctAnswers >= 10) ...[
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    'assets/congratulations.png',
                    width: 400,
                    height: 400,
                  ),
                  Positioned(
                    top: 0,
                    child: ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: true,
                      emissionFrequency: 0.05,
                      numberOfParticles: 25,
                      maxBlastForce: 30,
                      minBlastForce: 10,
                    ),
                  ),
                ],
              ),
            ],
            Text(
              "You answered correctly ${widget.correctAnswers} out of 10 !!! ",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
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
                ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(
                    Colors.deepPurpleAccent.shade100.withValues(alpha: 150),
                  ),
                ),
              ),
              child: const Text('Play Again', style: TextStyle(fontSize: 50)),
            ),
          ],
        ),
      ),
    );
  }
}
