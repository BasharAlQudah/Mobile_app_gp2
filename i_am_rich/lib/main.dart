import 'package:flutter/material.dart';

// THE MAIN IS THE STARTING POINT OF THIS APP
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // CREATE APP STRUCTURE
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            'I Am Rich',
          ),
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
        ),
        body: const Center(
          child: Image(
            alignment: Alignment.bottomRight,
            image: AssetImage('images/diamond.png'),
          ),
        ),
      ),
    ),
  );
}
