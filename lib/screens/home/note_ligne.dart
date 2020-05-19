import 'package:firstapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/models/note.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/models/user.dart';

class NoteLigne extends StatefulWidget {
  final Note note;
  const NoteLigne({this.note});
  @override
  _NoteLigneState createState() => _NoteLigneState();
}
class _NoteLigneState  extends State<NoteLigne> {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<User>(context);
    String choix;
    final GlobalKey _menuKey = new GlobalKey();
    dynamic statnote;


    if (widget.note.stat){
       statnote = Colors.green[100];
    }else{
      statnote = Colors.red[100];
    }

    void handlePopUpChanged(String value) async {
      choix =  value;
      if(choix == 'supprimer'){
          await DatabaseService(uid: usersData.uid).deleteNote(widget.note.nuid);
      }else{
        print("makhdmatch");
      }
      /// Log the selected lucky number to the console.

    }

    List<String> menuitems = ['supprimer'];
    List<PopupMenuItem> luckyNumbers = [];
    for (String item in menuitems) {
      luckyNumbers.add(
          new PopupMenuItem(
            child: new Text("$item"),
            value: item,
          )
      );
    }

    if(usersData.uid == widget.note.nuid){
      return StreamBuilder<UserDocument>(
          stream: DatabaseService(uid: usersData.uid).userDocument,
          builder:(context,snapshot) {
            return Padding (

              padding: EdgeInsets.only(top: 4.0),
              child: Card(
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: statnote ?? Colors.green[100] ,
                    ),
                    title: Text(widget.note.title),
                    subtitle: Text('Objet : ${widget.note.corp} '),
                    trailing: new PopupMenuButton(
                      key: _menuKey,
                      onSelected: (selectedDropDownItem) => handlePopUpChanged(selectedDropDownItem),
                      itemBuilder: (BuildContext context) => luckyNumbers,
                      tooltip: "cliquer pour selectionner une action.",
                    ),
                    /// trailing: Icon(Icons.more_vert),
                    onTap: () {
                      dynamic popUpMenustate = _menuKey.currentState;
                      popUpMenustate.showButtonMenu();
                    },
                  )
              ),
            );
          }
      );
    }else{
      return Container();
    }
    }
}
