import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/screens/displayscreen.dart';
import 'package:firebase_note_app/screens/note_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseUser user;
  Firestore firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = true;

  getUser() async {
    user = await _auth.currentUser();
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  deleteNote(String id) {
    firestore
        .collection("users")
        .document(user.uid)
        .collection("notes")
        .document(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: loading
          ? CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10.0),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Center(child: Text('Search..')),
                          SizedBox(
                            width: 3,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: StreamBuilder(
                        stream: firestore
                            .collection('users')
                            .document(user.uid)
                            .collection("notes")
                            .snapshots(),
                            
                        builder: (context, snapshot) {
                          
                          QuerySnapshot snap = snapshot.data;
                          List<DocumentSnapshot> notes = snap.documents;
                          return ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: notes.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot doc = notes[index];
                              Map body = doc.data;
                              return Dismissible(
                                  key: ObjectKey("${notes[index]}"),
                                  background: stackBehindDismiss(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (v) {
                                    deleteNote(doc.documentID);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => DisplayScreen(
                                              title: body,
                                              docId: doc,
                                            ),
                                          ),
                                        );
                                      },
                                      child: _buildNotes(
                                          context,
                                          "${body["title"]}",
                                          "${body["content"]}"),
                                    ),
                                  ));
                            },
                          );
                        }),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Theme.of(context).accentColor,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}

Widget _buildNotes(context, String title, String content) {
  return
      Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 20, top: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              maxLines: 1,
            ),

          ],
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(right: 115),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
            maxLines: 3,
          ),
        ),
      ],
    ),
  );
  //);
}
