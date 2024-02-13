import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calculator/category/home_screen.dart';
import 'package:calculator/note/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/login.dart';
import '../counter_provider/model/firebaseProvider.dart';
import '../category/add.dart';
import '../category/edit_category.dart';
import '../widgets/CardRow.dart';
import 'Edit.dart';

class NoteScreen extends StatefulWidget {
  static const String routeName = '/note';
  final String categoryid;

  const NoteScreen({super.key, required this.categoryid});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    context.read<ProviderFirebase>().getNote(widget.categoryid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        title: Text(
          'Note',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.refresh,
            color: Colors.orange,
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            color: Colors.orange,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.orange,
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
         return Future.value(false); },
        child: context.watch<ProviderFirebase>().isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: GridView.builder(
                      itemCount: context.read<ProviderFirebase>().note.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onLongPress: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'حدد ما الذي تريد فعلة بالعنصر($i)',
                              btnOkText: 'تعديل',
                              btnOkOnPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditNote(
                                      notedocId: context
                                          .read<ProviderFirebase>()
                                          .note[i]
                                          .id,
                                      oldName: context
                                          .read<ProviderFirebase>()
                                          .note[i]['note'],
                                      catdocId: widget.categoryid,
                                    ),
                                  ),
                                );
                              },
                              btnCancelText: 'حذف',
                              btnCancelOnPress: () {
                                context.read<ProviderFirebase>().isLoading = true;
                                context.read<ProviderFirebase>().deleteNote(
                                    context.read<ProviderFirebase>().note[i].id,widget.categoryid);
                                setState(() {});
                              },
                            ).show();
                          },
                          child: CardRow(
                              context.read<ProviderFirebase>().note[i]['note'],
                              'assets/images/logo.png'),
                        );
                      },
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNote(cat_id: widget.categoryid)));
        },
      ),
    );
  }
}
