import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                    letterSpacing: 2.5,
                  ),
                ),
                const Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                    fontFamily: 'Tienne',
                    fontSize: 15,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
                SizedBox(
                  height: 10,
                  child: Divider(
                    thickness: 1,
                    color: Colors.blueGrey.shade200,
                    indent: 40,
                    endIndent: 40.0,
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.blueGrey.shade300,
                    ),
                    title: Text(
                      '+962 9720 85 82',
                      style: TextStyle(
                        color: Colors.blueGrey.shade300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Card(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.mail,
                      color: Colors.blueGrey.shade300,
                    ),
                    title: Text(
                      'BasharQudah69@gmail.com',
                      style: TextStyle(
                        color: Colors.blueGrey.shade300,
                        fontSize: 15,
                      ),
                    ),
                  ),
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
