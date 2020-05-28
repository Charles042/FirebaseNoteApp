import 'package:firebase_note_app/widgets/loginForm.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 60,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
