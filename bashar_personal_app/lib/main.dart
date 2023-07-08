import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.fromLTRB(10, 80, 3, 421),
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Text('hello world'),
          ),
        ),
      ),
    );
  }
}
