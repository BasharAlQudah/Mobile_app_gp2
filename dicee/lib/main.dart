import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'hello',
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            letterSpacing: 12,
          ),
        ),
      ),
      body: const Dicee(),
    ),
  ));
}

class Dicee extends StatelessWidget {
  const Dicee({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('images/dice1.png'),
      color: Colors.black,
    );
  }
}
