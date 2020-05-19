import 'package:firstapp/models/UserData.dart';
import 'package:firstapp/screens/home/user_ligne.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<List<UserData>>(context) ?? [];
    return ListView.builder(
      itemCount: usersData.length,
        itemBuilder: (context,index) {
          return User_Ligne(user: usersData[index]);
        }
    );
  }
}
