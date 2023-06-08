import 'package:commy/constants.dart';
import 'package:commy/view/pages/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splash_view/splash_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      SplashView(
        done: Done(
          WelcomePage(),
          animationDuration: Duration(seconds: 4),
          curve: Curves.easeInOut,
        ),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Constants.deafultcolor, Constants.background]),

      ),
    );
  }
}
