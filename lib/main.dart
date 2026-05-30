import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NumberGuesserApp());
}

class NumberGuesserApp extends StatelessWidget {
  const NumberGuesserApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guesser',
      debugShowCheckedModeBanner: false, // Removes the debug banner at top right
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color for the app
        useMaterial3: true,         // Use modern Material 3 design
      ),
      home: const HomeScreen(), // Starts the app at the HomeScreen
    );
  }
}
