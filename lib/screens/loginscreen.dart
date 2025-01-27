import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frist/helper/show_snack_bar.dart';
import 'package:frist/screens/chat_screen.dart';
import 'package:frist/widgets/custombottun.dart';
import 'package:frist/widgets/widgettextfeild.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isloading = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Form(
            key: formkey,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        
                        Image.asset(
                          "assets/images/chatlogin.png",
                          width: 160,
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 144, 105, 151),
                              Color.fromARGB(255, 207, 174, 234)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'second',
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: customformtextfield(
                                icon: Icon(
                    Icons.email,
                    color:   Color.fromARGB(255, 144, 105, 151) ,
                  ),
                              hinttext: "Email",
                              onchanged: (data) {
                                email = data;
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: customformtextfield(
                                icon: Icon(
                    Icons.lock,
                    color:   Color.fromARGB(255, 144, 105, 151) ,
                  ),
                              obscuretext: true,
                              hinttext: "password",
                              onchanged: (data) {
                                password = data;
                              },
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        custombutton(
                          text: "login",
                          ontab: () async {
                            if (formkey.currentState!.validate()) {
                              isloading = true;
                              setState(() {});
                              try {
                                await loginuser(context);
                                Navigator.pushNamed(context, 'homescreen',arguments: email);
                              } on FirebaseAuthException catch (ex) {
                                if (ex.code == 'user-not-found') {
                                  showsnackbar(
                                      context, 'No user found for that email.');
                                } else if (ex.code == 'wrong-password') {
                                  showsnackbar(context,
                                      'Wrong password provided for that user.');
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                              isloading = false;
                              setState(() {});
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account ?",
                              style:
                                  TextStyle(fontSize: 16, fontFamily: 'second'),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'signupscreen');
                                },
                                child: Text('    Sign Up',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'second',
                                        color: Color.fromARGB(
                                            255, 144, 105, 151))))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginuser(BuildContext context) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>Homepage()));
  }
}
