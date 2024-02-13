import 'package:calculator/auth/signup.dart';
import 'package:calculator/counter_provider/model/LanguageProvider.dart';
import 'package:calculator/counter_provider/model/api_provider.dart';
import 'package:calculator/counter_provider/model/counter_model.dart';
import 'package:calculator/counter_provider/model/firebaseProvider.dart';
import 'package:calculator/category/add.dart';
import 'package:calculator/category/edit_category.dart';
import 'package:calculator/category/home_screen.dart';
import 'package:calculator/filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'auth/login.dart';
import 'note/add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.


  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('==========================================User is currently signed out!');
      } else {
        print('==========================================User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => ProviderApi()),
        ChangeNotifierProvider(create: (context) => ProviderFirebase()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
          fontFamily: 'ElMessiri',
          textTheme: ThemeData.light().textTheme.copyWith(
              headlineSmall: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold),
              titleLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold)),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'), // English
          // Spanish
        ],
        home: FilterFireStore() ,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          SignUp.routeName:(context) => SignUp(),
          Login.routeName: (context) =>Login(),
          AddCategory.routeName : (context) =>AddCategory(),
          EditCategory.routeName : (context) => EditCategory(),
          '/filter' : (context) => FilterFireStore(),


        },
      ),
    );
  }
}
