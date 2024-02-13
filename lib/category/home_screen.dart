import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calculator/auth/login.dart';
import 'package:calculator/counter_provider/model/firebaseProvider.dart';
import 'package:calculator/note/view.dart';
import 'package:calculator/category/add.dart';
import 'package:calculator/widgets/CardRow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_category.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProviderFirebase>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        title: Text(
          'الصفحة الرئيسية',
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
          : SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: GridView.builder(
                    itemCount: context.read<ProviderFirebase>().data.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onLongPress: () {
                          print(context.read<ProviderFirebase>().data[i].id);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'حدد ما الذي تريد فعلة بالعنصر($i)',
                            btnOkText: 'تعديل',
                            btnOkOnPress: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditCategory(
                                    docId: context
                                        .read<ProviderFirebase>()
                                        .data[i]
                                        .id,
                                    oldName: context
                                        .read<ProviderFirebase>()
                                        .data[i]['name'],
                                  ),
                                ),
                              );
                            },
                            btnCancelText: 'حذف',
                            btnCancelOnPress: () {
                              context.read<ProviderFirebase>().isLoading = true;
                              context.read<ProviderFirebase>().deleteCategory(
                                  context.read<ProviderFirebase>().data[i].id);
                              setState(() {});
                            },
                          ).show();
                        },
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NoteScreen(
                                  categoryid: context
                                      .read<ProviderFirebase>()
                                      .data[i]
                                      .id),
                            ),
                          );
                        },
                        child: CardRow(
                            context.read<ProviderFirebase>().data[i]['name'],
                            'assets/images/2.png'),
                      );
                    },
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AddCategory.routeName);
        },
      ),
    );
  }
}
