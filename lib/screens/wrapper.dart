import 'package:firstapp/models/user.dart';
import 'package:firstapp/screens/authentication/authenticate.dart';
import 'package:firstapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}
