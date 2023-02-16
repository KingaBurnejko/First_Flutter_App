import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key, required this.uniqueNumber}) : super(key: key);

  final int uniqueNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wykrywanie "odstającej" wartości'),
      ),
      body: Center(
        child: Text(
          '$uniqueNumber',
          style: const TextStyle(fontSize: 48.0),
        ),
      ),
    );
  }
}