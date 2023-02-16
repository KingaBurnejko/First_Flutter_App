import 'package:flutter/material.dart';
import 'result_screen.dart';

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
            content: const Text('Wprowadź przynajmniej 3 wartości'),
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
            content: const Text('Wprowadź dokładnie 1 "odstającą" wartość'),
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
        title: const Text('Wykrywanie "odstającej" wartości'),
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
                  hintText: 'Wprowadź dane',
                  errorStyle:
                      TextStyle(fontSize: 16.0, color: Color(0xFFFD1F4A)),
                  hintStyle:
                      TextStyle(fontSize: 24.0, color: Color(0xFF2D2C2E)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę wprowadzić dane';
                  }
                  try {
                    _numbers = value.split(',').map(int.parse).toList();
                    return null;
                  } catch (e) {
                    return 'Wprowadź odpowiedni format';
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