import 'package:commy/constants.dart';
import 'package:commy/view/component/home/custombuttonlogin.dart';
import 'package:commy/view/component/home/custombuttonsignup.dart';
import 'package:commy/view/pages/speachtotext.dart';
import 'package:flutter/material.dart';
import 'package:commy/view/component/home/customtextfield.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Constants.textcolor,
                                fontSize: 39,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Customtextform('E-Mail',
                              icon:
                                  Icon(Icons.email, color: Constants.iconcolor),
                              validator: (value) {
                            if (value.length == 0) {
                              return "Email Can not be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+.-]+@[a-zA-Z0-9+.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("please enter valid email");
                            } else {
                              return null;
                            }
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Customtextform('password',
                              icon: Icon(
                                Icons.password,
                                color: Constants.iconcolor,
                              )),
                        ),
                        Row(
                          children: [
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(color: Constants.textcolor),
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: CustombuttonLogin('Login', context)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                  color: Constants.textcolor, thickness: 2),
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Custombuttonsignup('Signup', context),
                        ),
//devtest
                      ],
                    ),
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
