import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Center(
          child: Text(
            'Editor',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              height: MediaQuery.of(context).size.height - 20,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                      controller: _title,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Title', hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ),
                  
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          controller: _content,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                              hintText: 'Type Notes...'),
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
