
import 'package:flutter/cupertino.dart';

class LanguageProvider with ChangeNotifier{
  bool isAr=false;
  String lng='EN';
  String? txt='What`s your Name?';
  void translate(){
    if(isAr){
       txt='ماهو اسمك';
      lng='EN';
      isAr=!isAr;
    }else{
      txt='What`s your Name?';
      lng='AR';
      isAr=!isAr;
    }
    notifyListeners();
  }
}