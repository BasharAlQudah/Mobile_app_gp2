import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'Dicee',
            style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: Dicee(),
    ),
  ));
}

class Dicee extends StatefulWidget {
  const Dicee({super.key});

  @override
  State<Dicee> createState() => _DiceeState();
}

class _DiceeState extends State<Dicee> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  @override
  Widget build(BuildContext context) {
    Random(DateTime.now().hour);
    void randomize() {
      setState(() {
        leftDiceNumber = Random().nextInt(6) + 1;
        rightDiceNumber = Random().nextInt(6) + 1;
      });
    }

    return Center(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  randomize();
                  print('$leftDiceNumber'); //3shan a6ab3 3ala console
                },
                child: Image.asset("images/dice$leftDiceNumber.png"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  randomize();
                  print("$rightDiceNumber"); //3shan a6ab3 3ala console
                },
                child: Image.asset('images/dice$rightDiceNumber.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
