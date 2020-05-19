import 'package:firstapp/screens/home/note_ligne.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/models/note.dart';


class NoteDataList extends StatefulWidget {
  @override
  _NoteDataListState createState() => _NoteDataListState();
}

class _NoteDataListState extends State<NoteDataList> {
  @override
  Widget build(BuildContext context) {
    final usersNote = Provider.of<List<Note>>(context) ?? [];
    /// print(usersNote);
    return ListView.builder(
        itemCount: usersNote.length,
        itemBuilder: (context,index) {
          return NoteLigne(note: usersNote[index]);
        }
    );
  }
}
