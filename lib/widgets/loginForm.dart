import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note_app/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool loading = false;
  bool isLoggedin = false;
  String _email;
  String _password;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  SharedPreferences preferences;

   @override
  void initState() {
    super.initState();
    isSignedIn();
  }
 void isSignedIn()  async{
 setState(() {
      loading = true;
    });
     preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();

    if (isLoggedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }

 }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          //    _buildEmail(),
          //    _buildpassWord(),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 40,
                width: 140,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.blueAccent,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),

                    onPressed: () {
                      handleSignIn();
                    }),
              ),
            ],
          ),
        ),
      );
  }


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
        data: ThemeData(primaryColor: Theme.of(context).accentColor),
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


    
    Future handleSignIn() async {
      preferences = await SharedPreferences.getInstance();
      setState(() {
        loading = true;
      });

      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final FirebaseUser firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await Firestore.instance
            .collection("users")
            .where("id", isEqualTo: firebaseUser.uid)
            .getDocuments();
            final List<DocumentSnapshot> documents = result.documents;

            if(documents.length == 0){
              Firestore.instance.collection("users").document(firebaseUser.uid).setData({
                 "id":firebaseUser.uid,
                 "username": firebaseUser.displayName,
                 "profilePicture": firebaseUser.photoUrl,
              }
              );
              await preferences.setString("id", firebaseUser.uid);
              await preferences.setString("username", firebaseUser.displayName);
              await preferences.setString("profilePicture", firebaseUser.photoUrl);

            }else{
              await preferences.setString("id", documents[0]['id']);
              await preferences.setString("username", documents[0]['username']);
              await preferences.setString("photoUrl", documents[0]['photoUrl']);
            }
            Fluttertoast.showToast(msg: "Login Successful");
            setState(() {
              loading = false;
            });
        //  print("signed in " + firebaseUser.displayName);
        // return firebaseUser;
      }else{

      }
    }
 
 }



