import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calculator/auth/signup.dart';
import 'package:calculator/category/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/custombuttonauth.dart';
import '../widgets/customlogoauth.dart';
import '../widgets/textformfield.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    // AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.error,
    //   animType: AnimType.rightSlide,
    //   title: 'Error',
    //   desc: 'No user found for that email.',
    //   btnCancelOnPress: () {},
    //   btnOkOnPress: () {},
    // ).show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                Form(
                  key: formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 50),
                      const CustomLogoAuth(),
                      Container(height: 20),
                      const Text("Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      Container(height: 10),
                      const Text("Login To Continue Using The App",
                          style: TextStyle(color: Colors.grey)),
                      Container(height: 20),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(height: 10),
                      CustomTextForm(
                        hinttext: "ُEnter Your Email",
                        mycontroller: email,
                        validator: (value) {
                          if (value == '') {
                            return 'لا يمكن ترك الحقل فارغ';
                          }
                        },
                      ),
                      Container(height: 10),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(height: 10),
                      CustomTextForm(
                        hinttext: "ُEnter Your Password",
                        mycontroller: password,
                        validator: (value) {
                          if (value == '') {
                            return 'لا يمكن ترك الحقل فارغ';
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        alignment: Alignment.topRight,
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButtonAuth(
                  title: "login",
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    if (formState.currentState!.validate()) {
                      try {
                        print(email.text);
                        print(password.text);
                        final UserCredential credential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        print(credential.user?.email ?? 'no email');

                        if (credential.user!.emailVerified) {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        } else {
                          isLoading=false;
                          setState(() {

                          });
                          //   credential.user!.sendEmailVerification();
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'يرجى التحقق من عنوان بريدك الإلكتروني',
                          ).show();
                        }
                      } on FirebaseAuthException catch (e) {
                        isLoading=false;
                        setState(() {

                        });
                        // AwesomeDialog(
                        //   context: context,
                        //   dialogType: DialogType.error,
                        //   animType: AnimType.rightSlide,
                        //   title: 'Error',
                        //   desc: e.code.toString(),
                        // ).show();
                        if (e.code == 'user-not-found') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'No user found for that email.',
                          ).show();
                          print('==============No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Wrong password provided for that user.',
                          ).show();
                          print(
                              '============================Wrong password provided for that user.');
                        }
                      }
                    }
                  },
                ),
                Container(height: 20),

                MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.red[700],
                    textColor: Colors.white,
                    onPressed: () {
                      signInWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login With Google"),
                        Image.asset(
                          "assets/images/4.png",
                          width: 20,
                        )
                      ],
                    )),
                Container(height: 20),
                // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(SignUp.routeName);
                  },
                  child: const Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "Don't Have An Account ? ",
                        ),
                        TextSpan(
                            text: "Register",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  ),
                )
              ]),
            ),
    );
  }
}
