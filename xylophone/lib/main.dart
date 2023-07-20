import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(xylophone());
}

class xylophone extends StatefulWidget {
  xylophone({super.key});

  @override
  State<xylophone> createState() => _xylophoneState();
}

class _xylophoneState extends State<xylophone> {
  void setSound({int i = 0}) {
    final Player = AudioPlayer();
    Player.play(AssetSource('note$i.wav'));
  }

  var color = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple
  ];

  Expanded BuildKey(int i) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setSound(i: i + 1);
          print('clicked $i');
        },
        style: TextButton.styleFrom(backgroundColor: color[i]),
        child: const Text(''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [for (int i = 0; i < color.length; i++) BuildKey(i)],
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
