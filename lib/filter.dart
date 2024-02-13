import 'package:calculator/counter_provider/model/firebaseProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';

class FilterFireStore extends StatefulWidget {
  const FilterFireStore({super.key});

  @override
  State<FilterFireStore> createState() => _FilterFireStoreState();
}

class _FilterFireStoreState extends State<FilterFireStore> {
  iniData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot usersdata = await users.get();
    usersdata.docs.forEach((element) {
      context.read<ProviderFirebase>().data.add(element);
    });
  }

  @override
  void initState() {
    //iniData();
    context.read<ProviderFirebase>().getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        title: Text(
          'Filtering',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.refresh,
            color: Colors.orange,
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            color: Colors.orange,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.orange,
            ),
          )
        ],
      ),
      body: context.watch<ProviderFirebase>().isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: context.read<ProviderFirebase>().data.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    DocumentReference documentReference = FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(context.read<ProviderFirebase>().data[i].id);
                    FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                      DocumentSnapshot snapshot =
                          await transaction.get(documentReference);

                      if (snapshot.exists) {
                        var snapshotData = snapshot.data();
                        if (snapshotData is Map<String, dynamic>) {
                          int monye = snapshotData['monye'] + 100;
                          transaction
                              .update(documentReference, {'monye': monye});
                        }
                      }
                    }).then((value){
                      Navigator.pushNamedAndRemoveUntil(context,'/filter', (route) => false);
                    }
                    
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                          context.read<ProviderFirebase>().data[i]['username'],
                          style: TextStyle(fontSize: 30)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context
                              .read<ProviderFirebase>()
                              .data[i]['age']
                              .toString()),
                          Text(context
                              .read<ProviderFirebase>()
                              .data[i]['phone']
                              .toString()),
                        ],
                      ),
                      trailing: Text(
                        '${context.read<ProviderFirebase>().data[i]['monye'].toString()}\$ ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
