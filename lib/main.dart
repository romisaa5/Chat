import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist/cubits/loginCubit/login_cubit.dart';
import 'package:frist/cubits/rigesterCubit/register_cubit.dart';
import 'package:frist/firebase_options.dart';
import 'package:frist/screens/chat_screen.dart';
import 'package:frist/screens/loginscreen.dart';
import 'package:frist/screens/signupscreen.dart';
import 'package:frist/screens/splash_screen.dart';
import 'package:frist/screens/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>LoginCubit() ),
        BlocProvider(create: (context)=>RegisterCubit())
      ],
      child: MaterialApp(
        routes: {
          'welcomescreen': (context) => WelcomeScreen(),
          'loginscreen': (context) => LoginScreen(),
          'signupscreen': (context) => SignupScreen(),
          'splashscreen': (context) => SplashScreen(),
          'homescreen': (context) => Homepage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: 'splashscreen',
      ),
    );
  }
}
