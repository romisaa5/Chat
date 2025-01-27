import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frist/helper/show_snack_bar.dart';
import 'package:frist/screens/chat_screen.dart';
import 'package:frist/widgets/custombottun.dart';
import 'package:frist/widgets/widgettextfeild.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? password;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(children: [
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
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'second',
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: customformtextfield(
                  icon: Icon(
                    Icons.email,
                    color:   Color.fromARGB(255, 144, 105, 151) ,
                  ),
                  onchanged: (data) {
                    email = data;
                  },
                  hinttext: "Email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: customformtextfield(
                    icon: Icon(
                    Icons.lock,
                    color:   Color.fromARGB(255, 144, 105, 151) ,
                  ),
                  obscuretext: true,
                  onchanged: (data) {
                    password = data;
                  },
                  hinttext: "password",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              custombutton(
                ontab: () async {
                  if (formkey.currentState!.validate()) {
                    isloading = true;
                    setState(() {});
                    try {
                      await signupmethod(context);
                        Navigator.pushNamed(
        context,'homescreen',arguments: email);
                  
                    } on FirebaseAuthException catch (ex) {
                      if (ex.code == 'weak-password') {
                        showsnackbar(
                            context, 'The password provided is too weak.');
                      } else if (ex.code == 'email-already-in-use') {
                        showsnackbar(context,
                            'The account already exists for that email.');
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
                text: "sign up",
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an account ?",
                    style: TextStyle(fontSize: 16, fontFamily: 'second'),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'loginscreen');
                      },
                      child: Text('    Login',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'second',
                              color: Color.fromARGB(255, 144, 105, 151))))
                ],
              )
            ]),
          ),
        ),
      ),
    ));
  }

  Future<void> signupmethod(BuildContext context) async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);

  
  }
}
