import 'package:firebase_note_app/screens/displayscreen.dart';
import 'package:firebase_note_app/screens/note_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Column(
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
                      )),
                    ]),
              ),
            ),
          ),
          Expanded(
            child: Container(
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(10),
                          child: _buildNotes(context));
                    })),
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
}

Widget _buildNotes(context) {
  return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DisplayScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 20, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Trip to Tokyo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  maxLines: 1,
                ),
                Spacer(),
                Text(
                  'May 27',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(right: 115),
              child: Text(
                'Preparing for our trip to Tokyo. Flight and Reservation ready!!',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ));
}
