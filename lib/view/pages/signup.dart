import 'package:commy/constants.dart';
import 'package:commy/view/component/home/custombuttonlogin.dart';
import 'package:commy/view/component/home/custombuttonsignup.dart';
import 'package:commy/view/pages/Auth.dart';
import 'package:commy/view/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController repasswordcontroller = TextEditingController();
  var formkey=  GlobalKey<FormState>();

  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  Future signupmethod() async {
    if (confirmedpassword()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const Auth();
        },
      ));
    }
  }

  bool confirmedpassword() {
    if (passwordcontroller.text.trim() == repasswordcontroller.text.trim()) {
      return true;
    } else
      return false;
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    repasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.deafultcolor,
      body: SafeArea(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: w,
                  height: h * 0.97,
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
                        const Padding(
                          padding: EdgeInsets.all(9.0),
                          child: Text(
                            'SignUp',
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
                                  hintText: "E-mail",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Constants.deafultcolor,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                autofocus: true,
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
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: TextFormField(
                              autofocus: true,
                              obscureText: true,
                              controller: repasswordcontroller,
                              validator: (PassCurrentValue) {
                                var passNonNullValue = PassCurrentValue ?? "";
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
                                  hintText: "Re-enter password",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Constants.deafultcolor,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FlutterPwValidator(
                            defaultColor: Constants.textcolor,
                            successColor: Constants.deafultcolor,
                            failureColor: Constants.textcolor,
                            key: validatorKey,
                            controller: passwordcontroller,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            numericCharCount: 2,
                            specialCharCount: 1,
                            normalCharCount: 3,
                            width: 400,
                            height: 150,
                            onSuccess: () {
                              print("MATCHED");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Constants.background,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(36)),
                                      content: const Text(
                                        "Password is matched",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Constants.textcolor),
                                      )));
                            },
                            onFail: () {
                              print("NOT MATCHED");

                            },
                          ),
                        ),
                        //signup button
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child:
                          Custombuttonsignup("Signup", context, () {
                            signupmethod();
                            if (formkey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          })
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
                        //login button
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child:
                          CustombuttonLogin("Login", context, () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ));
                          })
                        ),
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
