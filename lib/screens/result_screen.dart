import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int secretNumber;
  final int guessedNumber;

  const ResultScreen({
    Key? key,
    required this.secretNumber,
    required this.guessedNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String feedbackMessage;
    Color messageColor;

    if (guessedNumber == secretNumber) {
      feedbackMessage = 'Correct! You guessed it!';
      messageColor = Colors.green;
    } else if (guessedNumber < secretNumber) {
      feedbackMessage = 'Too low! Try a higher number.';
      messageColor = Colors.orange;
    } else {
      feedbackMessage = 'Too high! Try a lower number.';
      messageColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess Result'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.blue.shade50,
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Guess: $guessedNumber',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              feedbackMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: messageColor,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                // Use Navigator.pop to go back to the previous screen
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text(
                'Go Back',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
