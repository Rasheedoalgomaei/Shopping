import 'package:calculator/counter_provider/model/firebaseProvider.dart';
import 'package:calculator/category/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/textformfield.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  static const String routeName = '/ad';

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        title: Text(
          'Add category',
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
                  hinttext: 'Enter Name',
                  mycontroller: editingController,
                  validator: (val) {
                    if (val == '') {
                      return 'لا يمكن ترك الحقل فارغ';
                    }
                  }),
            ),
            MaterialButton(
              onPressed: (){
                if (_key.currentState!.validate()) {
                  context.read<ProviderFirebase>()
                      .addCategory(editingController.text);
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
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
