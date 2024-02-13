import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buildTextFormField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final String pattern;
  const buildTextFormField({
    super.key, required this.hintText, required this.iconData, required this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText:"hintText",
        icon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      validator: (value) {
        const namePattern = r'^[a-z A-Z,.\-]+$';
        final regex = RegExp(namePattern);
        if (value == null || value.isEmpty) {
          return 'Enter a value Plase!';
        } else if (regex.hasMatch(value!)) {
          return 'Enter a correct Value';
        }
        return null;
      },
    );
  }
}