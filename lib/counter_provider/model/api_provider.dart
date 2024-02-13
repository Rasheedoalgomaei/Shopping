import 'dart:convert';

import 'package:calculator/models/Department.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class ProviderApi with ChangeNotifier {
  var responsebody;
  List<Department>result=[];


  // getData() async {
  //   QuerySnapshot querySnapshot =
  //   await FirebaseFirestore.instance.collection('categories').get();
  //   data.addAll(querySnapshot.docs);
  //   setState((){
  //   });
  // }

  void requestApi() async{
   var response= await get(

      Uri.parse(
          'https://6a792b10-5369-4e8a-bac4-53c7973ad470.mock.pstmn.io/all-dept'),
    );
    responsebody=jsonDecode(response.body)as List<dynamic>;
     responsebody;
     for(int i=0;i<responsebody.length;i++){
       result.add(Department.fromMap(responsebody[i]));
     }
   print('result.first.name');
   print(responsebody.body);
    notifyListeners();
  }
}
