import 'package:commy/constants.dart';
import 'package:commy/view/pages/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      nextScreen: WelcomePage(),
      splash: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
           Image.asset("assets/images/photo_2023-02-26_14-44-51.jpg",
             height:MediaQuery.of(context).size.height*0.2,
             width:MediaQuery.of(context).size.width*0.8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Lets Commy',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Constants.textcolor),
                ),
              )
            ],
          ),
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
