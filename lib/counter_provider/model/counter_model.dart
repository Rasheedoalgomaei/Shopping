

import 'package:flutter/cupertino.dart';

class CounterProvider with ChangeNotifier{


  int counter=0;

  void increment(){
    counter++;
    notifyListeners();
  }
  void decrement(){
    counter--;
notifyListeners();
  }



}
