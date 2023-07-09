import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  child: Image(image: AssetImage('images/bashar-modified.png')),
                ),
                const Text(
                  'Bashar Al-Qudah',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'FLUTTER DEVELOPER',
                  style: GoogleFonts.tienne(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ), //Google fonts
                ),
              ], //Children
            ),
          ),
        ),
      ),
    );
  }
}

//
// mainAxisSize: MainAxisSize.min,
// // verticalDirection: VerticalDirection.up,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Container(
// height: 100,
// width: 100,
// // padding: const EdgeInsets.all(10),
// // margin: const EdgeInsets.all(5),
// color: Colors.white,
// child: const Text('container 1 '),
// ),
// const SizedBox(
// width: 10,
// ),
// Container(
// width: 100.0,
// height: 100.0,
// color: Colors.blue,
// // padding: const EdgeInsets.all(10),
// // margin: const EdgeInsets.all(5),
// child: const Text('container 2'),
// ),
// const SizedBox(
// width: 10,
// ),
// Container(
// width: 100.0,
// height: 100.0,
// color: Colors.red,
// // padding: const EdgeInsets.all(10),
// // margin: const EdgeInsets.all(5),
// child: const Text('container 3'),
// ),
// const SizedBox(
// width: 10,
// ),
// ],
