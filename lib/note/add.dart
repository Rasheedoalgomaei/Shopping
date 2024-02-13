import 'package:calculator/counter_provider/model/firebaseProvider.dart';
import 'package:calculator/category/home_screen.dart';
import 'package:calculator/note/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/textformfield.dart';

class AddNote extends StatefulWidget {
  final String cat_id;

  const AddNote({super.key, required this.cat_id});

  static const String routeName = '/add-note';

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        title: Text(
          'إضافة ملاحظة',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Form(
          key: _key,
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomTextForm(
                  hinttext: 'Enter Note',
                  mycontroller: note,
                  validator: (val) {
                    if (val == '') {
                      return 'لا يمكن ترك الحقل فارغ';
                    }
                  }),
            ),
            MaterialButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  context
                      .read<ProviderFirebase>()
                      .addNote(note.text, widget.cat_id);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          NoteScreen(categoryid: widget.cat_id),
                    ),
                  );
                }
              },
              child: Text(
                'Add',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Colors.orange,
            )
          ]),
        ),
      ),
    );
  }
}
