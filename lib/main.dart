import 'package:flutter/material.dart';
import 'input_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Wykrywanie "odstającej" wartości';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF5E6),
        primarySwatch: Colors.amber,
      ),
      home: const InputScreen(),
    );
  }
}