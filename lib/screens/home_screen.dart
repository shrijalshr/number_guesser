import 'package:flutter/material.dart';
import 'dart:math'; // Needed for random number generation
import 'result_screen.dart'; // Import the new result screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This is the secret number we want the user to guess
  int _secretNumber = 0;

  // This controller reads whatever the user types in the TextField
  final TextEditingController _guessController = TextEditingController();

  // This message tells the user if they are too high, too low, or correct
  String _feedbackMessage = '';

  // Keeps track of how many times the user guessed
  int _attempts = 0;

  @override
  void initState() {
    super.initState();
    _startNewGame(); // Start the game as soon as the screen loads
  }

  // A method to reset the game to its starting state
  void _startNewGame() {
    setState(() {
      // Pick a random number between 1 and 100
      _secretNumber = Random().nextInt(100) + 1;
      _feedbackMessage = 'Guess a number between 1 and 100!';
      _attempts = 0;
      _guessController.clear(); // Clear the text input field
    });
  }

  // A method to check the user's guess
  void _checkGuess() {
    // Hide the keyboard after pressing guess
    FocusScope.of(context).unfocus();

    // Read the text from our text controller
    String guessText = _guessController.text;

    // Make sure they actually typed something
    if (guessText.isEmpty) {
      setState(() {
        _feedbackMessage = 'Please enter a number.';
      });
      return; // Stop running the rest of this function
    }

    // Try to turn their text into a number
    int? guessNumber = int.tryParse(guessText);

    print("Secret number is $_secretNumber and Guessed number is $guessNumber");

    if (guessNumber == null) {
      // If it wasn't a valid number (like "abc")
      setState(() {
        _feedbackMessage = 'That is not a valid number.';
      });
      return;
    }

    // Since they entered a valid number, we increase their attempt count
    setState(() {
      _attempts++;
    });

    // Clear the input box so they can type another guess quickly
    _guessController.clear();

    // Navigate to the result screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          secretNumber: _secretNumber,
          guessedNumber: guessNumber,
          attempt: _attempts,
        ),
      ),
    ).then((_) {
      // Optional: if they guessed correctly and came back, reset the game
      if (guessNumber == _secretNumber) {
        _startNewGame();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Guesser'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // Nice color for the top bar
        foregroundColor: Colors.white, // White text color
      ),
      // We use a Container to add a soft background color
      body: Container(
        color: const Color.fromARGB(255, 151, 183, 206),
        padding: const EdgeInsets.all(24.0), // Spacing around the edges
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Vertically center items
            children: [
              // Display the hint or win message
              Text(
                _feedbackMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30), // Empty space for layout
              // Text field where the user types their guess
              TextField(
                controller: _guessController,
                keyboardType:
                    TextInputType.number, // Show a numbers-only keyboard
                decoration: InputDecoration(
                  labelText: 'Enter your guess',
                  hintText: 'e.g. 50',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16), // Rounded borders
                  ),
                  filled: true,
                  fillColor: Colors.white, // White background for the input
                  prefixIcon: const Icon(
                    Icons.calculate,
                  ), // A small icon on the left
                ),
                // Allow guessing by pressing 'Enter' on the keyboard
                onSubmitted: (_) => _checkGuess(),
              ),
              const SizedBox(height: 20),

              // The main button to check the guess
              ElevatedButton(
                onPressed: _checkGuess,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                ),
                child: const Text(
                  'Guess',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),

              // Only show the restart button if they have made at least one guess
              if (_attempts > 0)
                TextButton.icon(
                  onPressed: _startNewGame,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'Restart Game',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // We must throw away our controller when the screen is closed to save memory
    _guessController.dispose();
    super.dispose();
  }
}
