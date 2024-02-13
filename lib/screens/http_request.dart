import 'dart:convert';
import 'dart:developer';

import 'package:calculator/counter_provider/model/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class HttpRequestScreen extends StatelessWidget {
  const HttpRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HttpRequest'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                // int s = int.tryParse('1*2')??0;
                // int i =s;
                // log(i.toString());

                 context.read<ProviderApi>().requestApi();
                // var response = await get(
                //   Uri.parse(
                //       'https://6a792b10-5369-4e8a-bac4-53c7973ad470.mock.pstmn.io/employees/all-emp'),
                // );
                // var responseBody = jsonDecode(response.body);
                // print(responseBody[0]);
              },
              child: Text("Http Request"),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Center(child: Text(context.watch<ProviderApi>().result.toString()),
          )
        ],
      ),
    );
  }
}
