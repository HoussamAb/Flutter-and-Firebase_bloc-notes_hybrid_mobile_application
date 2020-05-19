import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/models/UserData.dart';
import 'package:firstapp/models/note.dart';
import 'package:firstapp/screens/home/noteData_Ligne.dart';
import 'package:firstapp/screens/home/noteEdit_form.dart';
import 'package:firstapp/screens/home/settings_form.dart';
import 'package:firstapp/screens/home/usersData_List.dart';
import 'package:firstapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {

        return Container(

          padding: EdgeInsets.symmetric(vertical: 30.0 , horizontal: 30.0),
          child: SettingsForm(),
        );

      });
    }

    void _showNoteFormPanel(){
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {

        return Container(

          padding: EdgeInsets.symmetric(vertical: 30.0 , horizontal: 30.0),
          child: NoteForm(),
        );

      });
    }
    return StreamProvider<List<Note>>.value(
      value: DatabaseService().usersNote,
        child: Scaffold(
            backgroundColor: Colors.orange[100],
          appBar: AppBar(
            title: Text('My Notes'),
            backgroundColor: Colors.redAccent[100],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(onPressed: () => _showSettingsPanel(), icon:Icon(Icons.person), label: Text('profile')),
              FlatButton.icon(onPressed: () async{ await _authService.logout(); }, icon: Icon(Icons.exit_to_app), label: Text('logout')),
            ],
          ),
            body: Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage('assets/note_bg.png'),
                )
              ),
              child:NoteDataList(),

            ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showNoteFormPanel();
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.redAccent,
          ),
      ),
    );
  }
}
