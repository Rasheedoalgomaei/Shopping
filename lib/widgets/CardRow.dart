import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final String name;
  final String imagUrl;
  const CardRow(this.name, this.imagUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            imagUrl,
            height: 160,
            fit: BoxFit.contain,
          ),
          Text(this.name),
        ],
      ),
    );
  }
}
