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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: 100,
                // padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.all(5),
                color: Colors.white,
                child: const Text('container 1 '),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
                // padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.all(5),
                child: const Text('container 2'),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100.0,
                height: 100.0,
                color: Colors.red,
                // padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.all(5),
                child: const Text('container 3'),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
