import 'package:commy/constants.dart';
import 'package:commy/view/pages/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: WelcomePage(),
      splash: Center(
        child: Column(
          children: [
           Icon(Icons.chat_outlined,color:Constants.iconcolor,size: 55),
            Text(
              'Lets Commy',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Constants.textcolor),
            )
          ],
        ),
      ),
      splashIconSize: 250,
      duration: 4000,
      splashTransition: SplashTransition.slideTransition,
      animationDuration: Duration(seconds: 1),
      backgroundColor: Constants.deafultcolor,
    );
  }
}
