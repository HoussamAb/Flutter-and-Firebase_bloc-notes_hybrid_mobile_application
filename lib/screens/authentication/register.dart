import 'package:firstapp/partagers/loading.dart';
import 'package:firstapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/partagers/constantes.dart';

class Register extends StatefulWidget {

  final Function view;

  const Register({Key key, this.view});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String erreur = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        elevation: 0.0,
        title: Text('Notes | New user '),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Login'),
            onPressed: () {
              widget.view();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Align(
                  alignment: Alignment.centerLeft, child: new Text('Email :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
              TextFormField(
                decoration: textFormDecor.copyWith(hintText: 'Enter votre email' ),
                validator: (val) => val.isEmpty ? 'Enter votre email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              Align(
                  alignment: Alignment.centerLeft, child: new Text('Password :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
              TextFormField(
                decoration: textFormDecor.copyWith(hintText: 'Enter votre password' ),
                validator: (val) => val.length < 8 ? '8 charactères requises au minimum' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 30.0,),
              RaisedButton(
                color: Colors.redAccent[200],
                child: Text('Valider',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                    if(result == null ){
                      setState(() {
                        erreur = 'veillez entrer un email valide !';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                erreur,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
