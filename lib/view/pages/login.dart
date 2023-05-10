import 'package:commy/constants.dart';
import 'package:commy/view/component/home/custombuttonlogin.dart';
import 'package:commy/view/component/home/custombuttonsignup.dart';
import 'package:commy/view/pages/Auth.dart';
import 'package:commy/view/pages/forgetpass/forgot_pass.dart';
import 'package:commy/view/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  Future login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim());
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Auth();
      },
    ));
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
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
            child: Form(
              key: formkey,
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(9.0),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    controller: emailcontroller,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email can not be empty';
                                      }
                                      if (!RegExp(
                                              "^[a-zA-Z0-9+.-]+@[a-zA-Z0-9+.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return ("please enter valid email");
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.email,
                                          color: Constants.iconcolor,
                                        ),
                                        hintText: "E-Mail",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Constants.deafultcolor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        )),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  controller: passwordcontroller,
                                  validator: (PassCurrentValue) {
                                    var passNonNullValue =
                                        PassCurrentValue ?? "";
                                    if (passNonNullValue.isEmpty) {
                                      return ("Password is required");
                                    } else if (passNonNullValue.length < 6) {
                                      return ("Password Must be more than 5 characters");
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: const Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Constants.iconcolor,
                                      ),
                                      hintText: "password",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Constants.deafultcolor,
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      )),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return ForgotPassword();
                                        },
                                      ));
                                    },
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Constants.textcolor),
                                    ))
                              ],
                            ),
                            // Login button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  CustombuttonLogin("Login", context, () async {
                                if (formkey.currentState!.validate()) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'email', emailcontroller.toString());
                                  // print(
                                  //     " login pagde${prefs.getString("email")}");
                                  login();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
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
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                      color: Constants.textcolor, thickness: 2),
                                )),
                              ],
                            ),
                            // Sign Up button
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Custombuttonsignup("Sign up", context, () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Signup();
                                    },
                                  ));
                                })),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
