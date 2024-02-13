import 'package:calculator/counter_provider/model/firebaseProvider.dart';
import 'package:calculator/category/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/textformfield.dart';

class EditCategory extends StatefulWidget {
  static const String routeName = '/edit-category';
  final String? docId;
  final String? oldName;
  EditCategory({this.docId, this.oldName});
 // EditCategory({required this.docId, required this.oldName});
  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController editingController = TextEditingController();
  //String argomentData;
  // CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  //
  // Future<void> addCategory() {
  //   // Call the user's CollectionReference to add a new user
  //   return categories
  //       .add({
  //     'name': editingController.text, // John Doe
  //
  //   })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
  CollectionReference categories =
  FirebaseFirestore.instance.collection('categories');



  // addCategory() async {
  //   if (_key.currentState!.validate()) {
  //     try {
  //       DocumentReference response = await categories.add(
  //         {
  //           'id' : FirebaseAuth.instance.currentUser!.uid,
  //           'name': editingController.text},
  //       );
  //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  //     } catch (e) {
  //       print('Error: $e ');
  //     }
  //   }
  // }
  @override
  void initState() {
    super.initState();
    editingController.text=widget.oldName!;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        title: Text(
          'Edit category',
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
                  mycontroller: editingController,
                  validator: (val) {
                    if (val == '') {
                      return 'لا يمكن ترك الحقل فارغ';
                    }
                  }),
            ),
            MaterialButton(
              onPressed: () async{
                if(_key.currentState!.validate()){
                  try{
                            context.read<ProviderFirebase>().updateCategory(widget.docId!,editingController.text);
                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                  }catch(e){

                  }
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
