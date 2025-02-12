import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist/cubits/rigesterCubit/register_cubit.dart';
import 'package:frist/helper/show_snack_bar.dart';
import 'package:frist/widgets/custombottun.dart';
import 'package:frist/widgets/widgettextfeild.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState >(
      listener: (context, state) {
      if (state is RegisterLoading) {
        
        } else if (state is RegisterSuccss) {

          Navigator.pushNamed(context, 'homescreen');
           
        } else if (state is RegisterFailure) {
          showsnackbar(context, state.errorMassege);
      
        }
      },
      builder: (context, state) {
        return SafeArea(
            child: ModalProgressHUD(
       inAsyncCall: State is RegisterLoading,
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
                        color: Color.fromARGB(255, 144, 105, 151),
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
                        color: Color.fromARGB(255, 144, 105, 151),
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
                        BlocProvider.of<RegisterCubit>(context).signupmethod(
                            context,
                            email: email!,
                            password: password!);
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
      },
    );
  }
}
