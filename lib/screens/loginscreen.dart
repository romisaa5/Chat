import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist/cubits/loginCubit/login_cubit.dart';
import 'package:frist/helper/show_snack_bar.dart';
import 'package:frist/widgets/custombottun.dart';
import 'package:frist/widgets/widgettextfeild.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
        
        } else if (state is LoginSuccess) {

          Navigator.pushNamed(context, 'homescreen');
           
        } else if (state is LoginFailure) {
          showsnackbar(context, state.errorMassege);
      
        }
      },
      builder: (context, State) => SafeArea(
        child: ModalProgressHUD(
       inAsyncCall: State is LoginLoading,
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
                                  color: Color.fromARGB(255, 144, 105, 151),
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
                                  color: Color.fromARGB(255, 144, 105, 151),
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
                                BlocProvider.of<LoginCubit>(context).loginuser(
                                    context,
                                    email: email!,
                                    password: password!);
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
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'second'),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'signupscreen');
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
      ),
    );
  }
}
