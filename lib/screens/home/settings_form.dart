import 'package:firstapp/models/UserData.dart';
import 'package:firstapp/models/user.dart';
import 'package:firstapp/partagers/loading.dart';
import 'package:firstapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/partagers/constantes.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  String _currentusername;
  String _currentphone;

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
                  Text('Mon profile', style: TextStyle(fontSize: 25.0),),
                  SizedBox(height: 10.0,),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Username :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextFormField(
                    initialValue: mydocument.username,
                    decoration: textFormDecor.copyWith(hintText: 'username' ),
                    validator: (val) => val.isEmpty ? 'username is emty' : null,
                    onChanged: (val){
                      setState(() {
                        _currentusername = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Telephone :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextFormField(
                    initialValue: mydocument.telephone,
                    decoration: textFormDecor.copyWith(hintText: 'telephone' ),
                    validator: (val) => val.isEmpty ? 'telephone is emty' : null,
                    onChanged: (val){
                      setState(() {
                        _currentphone = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Email :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextFormField(
                    enabled: false,
                    initialValue: mydocument.email,
                    decoration: textFormDecor.copyWith(hintText: 'email' ),
                  ),
                  SizedBox(height: 10.0,),
                  RaisedButton.icon(
                    onPressed: () async {
                   if(_formkey.currentState.validate()) {
                     await DatabaseService(uid: usersData.uid).updateUserData(
                         _currentusername ?? mydocument.username,
                         mydocument.email,
                         _currentphone ?? mydocument.telephone);
                   }
                   Navigator.pop(context);
                  }, label: Text('Update') ,icon: Icon(Icons.send,textDirection: TextDirection.ltr,), color: Colors.orange[100], padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),)
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
