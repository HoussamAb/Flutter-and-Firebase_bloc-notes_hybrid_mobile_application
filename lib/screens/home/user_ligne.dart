import 'package:flutter/material.dart';
import 'package:firstapp/models/UserData.dart';

class User_Ligne extends StatelessWidget {

  final UserData user;

  const User_Ligne({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.greenAccent[100 /*int.parse(user.telephone.substring(2,5))*/],
          ),
          title: Text(user.username),
          subtitle: Text('Email : ${user.email} Télé : ${user.telephone}' ),
        ),
      ),
    );
  }
}

