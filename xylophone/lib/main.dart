import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(xylophone());
}

class xylophone extends StatelessWidget {
  const xylophone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: TextButton(
              onPressed: () {
                final Player = AudioPlayer();
                Player.play(AssetSource('note1.wav'));
                print('clicked');
              },
              child: const Text('click me'),
            ),
          ),
        ),
      ),
    );
  }
}

//
// Padding(
// padding: const EdgeInsets.all(0.0),
// child: Column(
// mainAxisSize: MainAxisSize.max,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Expanded(
// flex: 1,
// child: Container(
// child: Center(
// child: Text(
// 'hello world',
// style: TextStyle(
// color: Colors.black,
// ),
// ),
// ),
// color: Colors.blue,
// ),
// ),
// Expanded(
// flex: 1,
// child: Container(
// color: Colors.red,
// ),
// ),
// Expanded(
// flex: 1,
// child: Container(
// color: Colors.green,
// ),
// ),
// Expanded(
// flex: 1,
// child: Container(
// color: Colors.yellow,
// ),
// ),
// Expanded(
// flex: 1,
// child: Container(
// color: Colors.purple,
// ),
// ),
// ],
// ),
// )
