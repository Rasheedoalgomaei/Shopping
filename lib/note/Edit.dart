import 'package:calculator/counter_provider/model/firebaseProvider.dart';
import 'package:calculator/category/home_screen.dart';
import 'package:calculator/note/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/textformfield.dart';

class EditNote extends StatefulWidget {
  static const String routeName = '/edit-note';
  final String? notedocId;
  final String? oldName;
  final String? catdocId;

  EditNote({this.notedocId, this.oldName, this.catdocId});

  // EditCategory({required this.docId, required this.oldName});
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController noteController = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  @override
  void initState() {
    super.initState();
    noteController.text = widget.oldName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        title: Text(
          'تعديل الملاحظة',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Form(
          key: _key,
          child: Column(children: [
            Text(''),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomTextForm(
                  hinttext: 'Enter Name',
                  mycontroller: noteController,
                  validator: (val) {
                    if (val == '') {
                      return 'لا يمكن ترك الحقل فارغ';
                    }
                  }),
            ),
            MaterialButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  try {
                    context
                        .read<ProviderFirebase>()
                        .updateNote(widget.notedocId!,widget.catdocId!, noteController.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>NoteScreen(categoryid: widget.catdocId!)));

                  } catch (e) {}
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
