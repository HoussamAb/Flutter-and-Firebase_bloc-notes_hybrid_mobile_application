import 'package:firstapp/models/user.dart';
import 'package:firstapp/partagers/loading.dart';
import 'package:firstapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/partagers/constantes.dart';
import 'package:provider/provider.dart';


class NoteForm extends StatefulWidget {
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {

  final _formkey = GlobalKey<FormState>();
  String _currentcorps;
  String _currenttitle;
  bool _currentstat;

  void _handleRadioValueChange(bool value){
    setState(() {
      _currentstat = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<User>(context);

    return StreamBuilder<UserDocument>(
        stream: DatabaseService(uid: usersData.uid).userDocument,
        builder:(context,snapshot) {
          if(snapshot.hasData){
            UserDocument mydocument = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text('Create Note', style: TextStyle(fontSize: 25.0),),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textFormDecor.copyWith(hintText: 'title' ),
                    validator: (val) => val.isEmpty ? 'title is emty' : null,
                    onChanged: (val){
                      setState(() {
                        _currenttitle = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textFormDecor.copyWith(hintText: 'corps' ),
                    validator: (val) => val.isEmpty ? 'corps is emty' : null,
                    onChanged: (val){
                      setState(() {
                        _currentcorps = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Radio(
                      value: false,
                      groupValue: _currentstat,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text('urgent'),
                    Radio(
                      value: true,
                      groupValue: _currentstat,
                      onChanged: _handleRadioValueChange,
                    ),
                    new Text('facultatif'),
                    ]
                  ),
                  SizedBox(height: 10.0,),
                  RaisedButton.icon(onPressed: () async {
                    if(_formkey.currentState.validate()) {
                      await DatabaseService(uid: usersData.uid).createNote(
                          _currenttitle ?? '',
                          _currentcorps ?? '',
                          _currentstat ?? false,
                          usersData.uid);
                      Navigator.pop(context);
                    }
                    //
                  }, label: Text('Create') ,icon: Icon(Icons.send,textDirection: TextDirection.ltr,), color: Colors.orange[100], padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),)
                ],
              ),
            );
          }else {
            return Loading();
          }
        }
    );
  }
}
