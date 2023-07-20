import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      xylophone(),
    );

class xylophone extends StatefulWidget {
  xylophone({super.key});

  @override
  State<xylophone> createState() => _xylophoneState();
}

class _xylophoneState extends State<xylophone> {
  void PlaySound({int i = 0}) {
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

  Expanded BuildKey(int i) => Expanded(
        child: TextButton(
          onPressed: () {
            PlaySound(i: i + 1);
            print('clicked $i');
          },
          style: TextButton.styleFrom(backgroundColor: color[i]),
          child: Center(child: const Text('')),
        ),
      );

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
