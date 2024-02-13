import 'package:flutter/material.dart';

import '../widgets/buildTextFormField.dart';

class FormScreen extends StatelessWidget {
  //const FormScreen({super.key});

  final _keyForm = GlobalKey<FormState>();

  final phonePattern = r'^(?:[+0][1-9])?[0-9]{11}$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Form(
          key: _keyForm,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            children: [
              //buildTextFormField(hintText: '',),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) {
                  const emailPattern =
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                  final regex = RegExp(emailPattern);
                  if (value == null || value.isEmpty) {
                    return 'Enter a value Plase!';
                  } else if (regex.hasMatch(value!)) {
                    return 'Enter a correct Value';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'password',
                  icon: Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                validator: (value) {
                  const passwordPattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

                  final regex = RegExp(passwordPattern);
                  if (value == null || value.isEmpty) {
                    return 'Enter a value Plase!';
                  } else if (regex.hasMatch(value!)) {
                    return 'Enter a correct Value';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    print('Done');
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


