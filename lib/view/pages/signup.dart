import 'package:commy/constants.dart';
import 'package:commy/view/pages/Auth.dart';
import 'package:commy/view/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController repasswordcontroller = TextEditingController();

  Future signupmethod() async {
    if (confirmedpassword()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Auth();
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
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.email,color: Constants.iconcolor,),
                                  hintText: "E-mail",
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
                        Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                autofocus: true,
                                obscureText: true,
                                controller: passwordcontroller,
                                decoration: InputDecoration(
                                    suffixIcon:
                                        Icon(Icons.remove_red_eye_outlined,color: Constants.iconcolor,),
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
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.remove_red_eye_outlined,color: Constants.iconcolor,),
                                  hintText: "Re-enter password",
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Constants.deafultcolor),
                            autofocus: true,
                            onPressed: () {
                              signupmethod();
                            },
                            child: Container(
                              width: size.width * 0.6,
                              height: size.height * 0.06,
                              child: Center(
                                  child: Text(
                                "Signup",
                                style: TextStyle(color: Constants.background),
                              )),
                            ),
                          ),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Divider(
                                      color: Constants.textcolor, thickness: 2),
                                )),
                            Text('OR',style: TextStyle(color: Constants.textcolor,
                                fontWeight: FontWeight.bold,fontSize: 23),),
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Divider(
                                      color: Constants.textcolor, thickness: 2),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child:ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Constants.background),
                            autofocus: true,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Login();
                                },
                              ));
                            },
                            child: Container(
                              width: size.width * 0.6,
                              height: size.height * 0.06,
                              child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Constants.deafultcolor),
                                  )),
                            ),
                          ),
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
