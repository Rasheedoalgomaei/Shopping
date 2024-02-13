import 'package:calculator/category/add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderFirebase extends ChangeNotifier {
  var isLoading = true;

  List<QueryDocumentSnapshot> data = [];
  List<QueryDocumentSnapshot> note = [];

  void getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    // await Future.delayed(Duration(seconds: 1));
    if (data.length > 0) {
      data.clear();
    }
    data.addAll(querySnapshot.docs);
    notifyListeners();
    isLoading = false;
  }


  void getUsers() async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot usersdata = await users.orderBy('age',descending: true).get();
    usersdata.docs.forEach((element) {
     data.add(element);
     isLoading = false;
  });
    print('lenth: ${data.length}');
    notifyListeners();
        }

  void getNote(String categoryid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryid)
        .collection('note')
        .get();
    if (note.length > 0) {
      note.clear();
    }
    note.addAll(querySnapshot.docs);
    notifyListeners();
    isLoading = false;
    print(categoryid);
  }

  void removeItem(String id) {
    // data.removeAt(id);
    data.removeWhere((element) => id == element.id);
    notifyListeners();
  }

  deleteCategory(String id) async {
    print(isLoading);
    CollectionReference categories =
    await FirebaseFirestore.instance.collection('categories');
    categories.doc(id).delete().then((value) {
      print("category Deleted");
      data.removeWhere((element) => id == element.id);
      notifyListeners();
      isLoading = false;
    }).catchError((error) => print("Failed to delete category: $error"));
  }
  deleteNote(String noteDocid,String catDocid) async {
    print(isLoading);
    CollectionReference notes =
    await FirebaseFirestore.instance.collection('categories').doc(catDocid).collection('note');
    notes.doc(noteDocid).delete().then((value) {
      print("Note Deleted");
      note.removeWhere((element) => noteDocid == element.id);
      notifyListeners();
      isLoading = false;
    }).catchError((error) => print("Failed to Note category: $error"));
  }

  updateCategory(String id, String newValue) async {
    isLoading = true;
    CollectionReference categories =
    await FirebaseFirestore.instance.collection('categories');
    //print(id);
    categories
        .doc(id)
        .update({'name': newValue})
        .then(
          (value) => print("categories Updated"),
    )
        .catchError(
          (error) => print("Failed to update categories:$error"),
    );
  }

  updateNote(String noteDocid,String catDocid, String newValue) async {
    isLoading = true;
    CollectionReference categories = await
     FirebaseFirestore.instance.collection('categories').doc(catDocid).collection('note');
    categories
        .doc(noteDocid)
        .update({'note': newValue})
        .then(
          (value) => print("Note Updated"),
    )
        .catchError(
          (error) => print("Failed to update note:$error"),
    );
  }

  addCategory(String catName) async {
    CollectionReference categories =
    FirebaseFirestore.instance.collection('categories');
    await categories.doc().set({'name': catName}, SetOptions(merge: true));
  }

  addNote(String note, String cat_id) async {
    CollectionReference noteRef =
     FirebaseFirestore.instance.collection('categories').doc(cat_id).collection(
        'note');
    await noteRef.add({'note': note});

  }
}
