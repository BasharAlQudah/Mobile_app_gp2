import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("I don't have any money"),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
        ),
        body: const Center(
          child: Image(
            image: AssetImage("image/icons8-poor-96.png"),
          ),
        ),
      ),
    ),
  );
}
