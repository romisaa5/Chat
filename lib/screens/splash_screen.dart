import 'package:flutter/material.dart';
import 'package:frist/screens/welcomescreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: Image.asset(
                        "assets/images/splash.png",
                        height: 130,
                        width: 130,
                      ),
                    ),
                  ),
                ),
                const Text("Developed By Romisaa Fadel",
                    style: TextStyle(
                      color: Colors.grey,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
