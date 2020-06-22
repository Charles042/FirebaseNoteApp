/*
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController text = TextEditingController();
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool loading = true;
  bool edit = false;
  String documentID;

  createNote() {
    if (text.text.isNotEmpty) {
      firestore.collection("users").document(user.uid).collection("notes").add({
        "note": "${text.text}",
      });
      text.clear();
    } else {
      showInSnackBar("Note cannot be empty");
    }
  }

  deleteNote(String id) {
    firestore.collection("users").document(user.uid)
        .collection("notes").document(id).delete();
  }

  updateNote() {
    firestore.collection("users").document(user.uid)
        .collection("notes").document(documentID).updateData({
      "note": text.text
    });
    text.clear();
    setState(() {
      edit = false;
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  getUser() async {
    user = await auth.currentUser();
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Notes",
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : buildList(),
    );
  }

  buildList(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: text,
            decoration: InputDecoration(
              hintText: "Type something....",
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            onPressed: edit
                ?() => updateNote()
                :() => createNote(),
            child: Text(
              edit?"Update":"Create",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Flexible(
            child: StreamBuilder(
              stream: firestore.collection("users")
                  .document(user.uid).collection("notes")
                  .snapshots(),
              builder: (context, snapshot) {
                QuerySnapshot snap = snapshot.data;
                List<DocumentSnapshot> notes = snap.documents;
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot doc = notes[index];
                    Map body = doc.data;
                    return Dismissible(
                      onDismissed: (v){
                        deleteNote(doc.documentID);
                      },
                      background: _dismissibleBackground(),
                      key: ObjectKey("${notes[index]}"),
                      child: ListTile(
                        onTap: (){
                          edit = true;
                          documentID = doc.documentID;
                          text.text = body["note"];
                          setState(() {});
                        },
                        title: Text("${body["note"]}"),
                      ),
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  _dismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}

*/