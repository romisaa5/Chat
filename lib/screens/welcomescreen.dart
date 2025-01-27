import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Center(
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 144, 105, 151),
                              Color.fromARGB(255, 207, 174, 234)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Text(
                            'PingIt',
                            style: TextStyle(
                              fontFamily: 'second',
                              fontSize: 55.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontFamily: 'second',
                        fontSize: 18,
                        color: const Color.fromARGB(255, 86, 86, 86),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Image.asset(
                        "assets/images/girlchat.jpg",
                        width: 270,
                        height: 270,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 200, 184, 229),
                          ),
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              horizontal: 79, vertical: 10)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27))))),
                      onPressed: () {
                        Navigator.pushNamed(context, 'loginscreen');
                      },
                      child: Text(
                        " Login  ",
                        style: TextStyle(fontSize: 17, color: Colors.grey[850]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 200, 184, 229),
                          ),
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                              horizontal: 79, vertical: 10)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27))))),
                      onPressed: () {
                        Navigator.pushNamed(context, 'signupscreen');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 17, color: Colors.grey[850]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
