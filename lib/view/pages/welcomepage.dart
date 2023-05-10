import 'dart:async';

import 'package:commy/constants.dart';
import 'package:commy/view/component/home/custombuttonlogin.dart';
import 'package:commy/view/component/home/custombuttonsignup.dart';
import 'package:commy/view/pages/login.dart';
import 'package:commy/view/pages/signup.dart';
import 'package:commy/view/pages/speachtotext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var finalemail;

  Future Getvalidationdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getemail = prefs.getString('email');
    setState(() {
      finalemail = getemail;
    });
  //  print(finalemail);
  }

  @override
  void initState() {
    Getvalidationdata().whenComplete(() async {
   //   print("init state$finalemail");
      if (finalemail != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SpeechScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.deafultcolor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: w,
                  height: h * 0.75,
                  decoration: const BoxDecoration(
                    color: Constants.background,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Let's Commy ",
                              style: TextStyle(
                                  color: Constants.textcolor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: CustombuttonLogin("Login", context, () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ));
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Divider(
                                color: Constants.textcolor, thickness: 2),
                          )),
                          Text(
                            'OR',
                            style: TextStyle(
                                color: Constants.textcolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Divider(
                                color: Constants.textcolor, thickness: 2),
                          )),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Custombuttonsignup("Sign up", context, () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Signup();
                              },
                            ));
                          }))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
