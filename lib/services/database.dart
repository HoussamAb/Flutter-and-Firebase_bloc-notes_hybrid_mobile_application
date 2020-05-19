import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/models/UserData.dart';
import 'package:firstapp/models/note.dart';
import 'package:firstapp/models/user.dart';
import 'package:flutter/material.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  var db = Firestore.instance;
  //collections refferences
  final CollectionReference notesCollection = Firestore.instance.collection('notes');
  final CollectionReference usersCollection = Firestore.instance.collection('users');


  Future updateNoteUser(String title, String corps , bool stat) async {
    return await notesCollection.document(uid).setData({
      'title': title,
      'corp': corps,
      'stat': stat,
    });

  }

  Future updateUserData (String username, String email, String telephone) async {
    return await usersCollection.document(uid).setData({
      'username': username,
      'email':email,
      'telephone':telephone,
    });
  }

  Future createNote (String title, String corps , bool stat, String nuid) async {
    return await notesCollection.add({
      'title': title,
      'corp': corps,
      'stat': stat,
      'nuid': nuid,
    });
  }

  Future deleteNote (String id) async {
    return await notesCollection.where("nuid", isEqualTo: id).getDocuments().then((snapshot){
      snapshot.documents.first.reference.delete();
    });
  }


  // get the list of notes of user
  Stream<List<Note>> get usersNote {
    return notesCollection.snapshots()
        .map(convertSnapshotToNotes);
  }
  // convert data to list of notes
  List<Note> convertSnapshotToNotes(QuerySnapshot snapshot){
    return snapshot.documents.map((e) {
      return Note(
        title: e.data['title'] ?? '',
        corp: e.data['corp'] ?? '',
        stat: e.data['stat'] ?? '',
        nuid: e.data['nuid'] ?? '',
      );
    }).toList();
  }

  // list of the data of all user
  Stream<List<UserData>> get usersData {
    return usersCollection.snapshots()
    .map(convertSnapShotsToUserDara);
  }

  List<UserData> convertSnapShotsToUserDara(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        username: doc.data['username'] ?? '',
        telephone: doc.data['telephone'] ?? '',
        email: doc.data['email'] ?? '',
      );
    }).toList();
  }

  // current user data
  Stream<UserDocument> get userDocument {
    return usersCollection.document(uid).snapshots()
    .map(_userDocument);
  }

  UserDocument _userDocument(DocumentSnapshot documentSnapshot){
    return UserDocument(
      uid:uid,
      email:documentSnapshot.data['email'],
      telephone:documentSnapshot.data['telephone'],
      username:documentSnapshot.data['username'],
    );
  }
}



