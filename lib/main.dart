import 'package:firebase_note_app/screens/homescreen.dart';
import 'package:firebase_note_app/utils/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp((MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Constants.darkTheme,
      home: HomeScreen(),
    );
  }
}