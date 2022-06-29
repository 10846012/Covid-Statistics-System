import 'package:flutter/material.dart';
import 'package:front_end/loginPage/loginPage.dart';
import 'package:front_end/mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-Statistics-System',
      home: loginPage(),
    );
  }
}
