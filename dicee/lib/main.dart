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

class Dicee extends StatelessWidget {
  Dicee({super.key});
  @override
  Widget build(BuildContext context) {
    Random(DateTime.now().hour);
    var leftDiceNumber = 1;
    var rightDiceNumber = 1;
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  leftDiceNumber = Random().nextInt(6) + 1;
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
                  rightDiceNumber = Random().nextInt(6) + 1;
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
