import 'package:calculator/models/item.dart';
import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  String? n1, n2;
  String result = '--';
  Color? txtcolor;
  Color? itemcolor;

  TextStyle stl = TextStyle(color: Colors.amber, fontWeight: FontWeight.bold);
  void sum() {
    result = (int.parse(n1!) + int.parse(n2!)).toString();
    notifyListeners();
  }

  List<Items> list = [
    Items(name: 'Rasheedo'),
    Items(name: 'Ezz'),
    Items(name: 'mohamed'),
    Items(name: 'yazen')
  ];

  void addItem(String name) {
    list.add(Items(name: result));
    notifyListeners();
  }

  void changeStyle() {
    notifyListeners();
  }

  void remveItem(Items items) {
    list.removeWhere((element) => items == element);
    print(' LENGTH = ' + list.length.toString());

    notifyListeners();
  }
}
