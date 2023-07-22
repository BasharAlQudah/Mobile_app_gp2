import 'package:flutter/material.dart';
import 'package:gp2_mobile_app/homePage.dart';
import 'package:gp2_mobile_app/login.dart';
import 'package:gp2_mobile_app/register.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'homepage': (context) => HomePage()
        }),
  );
}
