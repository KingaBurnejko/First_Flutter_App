import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'My Recrutation App';

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

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<int> _numbers;

  void _findUniqueNumber() {
    if (_numbers.length < 3) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter at least 3 valid numbers'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    List<int> evenNumbers = [];
    List<int> oddNumbers = [];

    for (int number in _numbers) {
      if (number.isEven) {
        evenNumbers.add(number);
      } else {
        oddNumbers.add(number);
      }
    }

    int uniqueNumber;

    if (evenNumbers.length == 1) {
      uniqueNumber = evenNumbers.first;
    } else if (oddNumbers.length == 1) {
      uniqueNumber = oddNumbers.first;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter exactly 1 unique number'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(uniqueNumber: uniqueNumber),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp._title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              TextFormField(
                style:
                    const TextStyle(fontSize: 22.0, color: Color(0xFF2D2C2E)),
                decoration: const InputDecoration(
                  hintText: 'Enter numbers',
                  errorStyle:
                      TextStyle(fontSize: 18.0, color: Color(0xFFFD1F4A)),
                  hintStyle:
                      TextStyle(fontSize: 24.0, color: Color(0xFF2D2C2E)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some numbers';
                  }
                  try {
                    _numbers = value.split(',').map(int.parse).toList();
                    return null;
                  } catch (e) {
                    return 'Please enter valid numbers separated by commas';
                  }
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _findUniqueNumber();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                ),
                child: const Text(
                  'Wyszukaj',
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key, required this.uniqueNumber}) : super(key: key);

  final int uniqueNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp._title),
      ),
      body: Center(
        child: Text(
          '$uniqueNumber',
          style: const TextStyle(fontSize: 46.0),
        ),
      ),
    );
  }
}
