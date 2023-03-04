import 'package:commy/constants.dart';
import 'package:commy/view/pages/Auth.dart';
import 'package:commy/view/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();


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
    Size size = MediaQuery.of(context).size;
    GlobalKey<FormState> formKey = new GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Constants.deafultcolor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                                        suffixIcon: Icon(
                                          Icons.email,
                                          color: Constants.iconcolor,
                                        ),
                                        hintText: "E-Mail",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
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
                                )),
                            Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  autofocus: true,
                                  obscureText: true,
                                  controller: passwordcontroller,
                                  validator: (PassCurrentValue){
                                    RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    var passNonNullValue=PassCurrentValue??"";
                                    if(passNonNullValue.isEmpty){
                                      return ("Password is required");
                                    }
                                    else if(passNonNullValue.length<6){
                                      return ("Password Must be more than 5 characters");
                                    }
                                    else if(!regex.hasMatch(passNonNullValue)){
                                      return ("Password should contain upper,lower,digit and Special character ");
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Constants.iconcolor,
                                      ),
                                      hintText: "password",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
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
                            // Login button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    backgroundColor: Constants.deafultcolor),
                                autofocus: true,
                                onPressed: () {
                                  login();
                                  if (formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data')),
                                    );
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.6,
                                  height: size.height * 0.06,
                                  child: Center(
                                      child: Text(
                                    'Login',
                                    style: TextStyle(color: Constants.textcolor),
                                  )),
                                ),
                              ),
                            ),
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
                            // Sign Up button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    backgroundColor: Constants.background),
                                autofocus: true,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Signup();
                                    },
                                  ));
                                },
                                child: Container(
                                  width: size.width * 0.6,
                                  height: size.height * 0.06,
                                  child: Center(
                                      child: Text(
                                    "SignUp",
                                    style: TextStyle(color: Constants.deafultcolor),
                                  )),
                                ),
                              ),
                            ),
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
