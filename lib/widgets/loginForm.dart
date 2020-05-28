import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email;
  String _password;
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  bool _success;

 


  Widget _buildEmail() {
    return Theme(
      data: ThemeData(primaryColor: Theme.of(context).accentColor),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is Required';
          }
          if (!RegExp(
                  r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
              .hasMatch(value)) {
            return 'Please enter a valid Email';
          }
          return null;
        },
        onSaved: (String value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildpassWord() {
    return Theme(
      data: ThemeData(
        primaryColor: Theme.of(context).accentColor
      ),
      child: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password is Required';
          }
          return null;
        },
        onSaved: (String value) {
          _password = value;
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Form(
        key: _loginKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildEmail(),
            _buildpassWord(),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 40,
              width: 140,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.blueAccent,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  if (_loginKey.currentState.validate()) {
                    _register();
                  }
                }
              ),
            ),
             Container(
              alignment: Alignment.center,
              child: Text(_success == null
                  ? ''
                  : (_success
                      ? 'Successfully LoggedIn ' + _email
                      : 'Login failed')),
            )
          ],
        ),
      ),
    );
  }
   @override
  void dispose() {
  
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  
  void _register() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _email = user.email;
      });
    } else {
      _success = false;
    }
  }
}
