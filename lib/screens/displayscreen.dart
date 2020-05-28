import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  final bool edit;

  const DisplayScreen({Key key, this.edit = false}) : super(key: key);

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  FocusNode titleFocus = FocusNode();
  bool edit = false;
  @override
  void initState() {
    edit = widget.edit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              _buildSaveEdit(),
            ],
          ),
        ],
      ),
      body: edit ? _buildEdit() : _buildNoteContent(),
    );
  }

  Widget _buildNoteContent() {
    return ListView(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            'Trip to Tokyo',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Divider(
          color: Theme.of(context).accentColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          'Preparing for our trip to Tokyo. Flight and Reservation ready!!',
          style: TextStyle(fontSize: 16),
        ),
      ),
    ]);
  }

  Widget _buildEdit() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _title,
              focusNode: titleFocus,
              decoration: InputDecoration.collapsed(
                hintText: 'Trip to Tokyo',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(
              color: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: _content,
              decoration: InputDecoration.collapsed(
                hintText:
                    'Preparing for our trip to Tokyo. Flight and Reservation ready!!',
                hintStyle: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildSaveEdit() {
    if (edit) {
      IconButton(
        icon: Icon(Icons.check),
        onPressed: () {},
      );
    } else {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {},
      );
    }
  }
}
