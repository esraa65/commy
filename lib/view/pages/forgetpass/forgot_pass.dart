import 'package:commy/constants.dart';
import 'package:commy/view/component/home/custombuttonsignup.dart';
import 'package:commy/view/pages/forgetpass/verify_your_email.dart';
import 'package:commy/view/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController forgetpasswordcontroller =
      TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Forget Password",
            style: TextStyle(
              fontSize: 19,
              color: Constants.textcolor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(
              builder: (context) {
                return Login();
              },
            ));
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Constants.iconcolor,
            size: 33,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/photo_2023-05-04_22-14-29.jpg",
                    fit: BoxFit.fill),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                const Text(
                  "Please enter your email address to recieve vervication code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Constants.textcolor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
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
                    controller: forgetpasswordcontroller,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.email,
                          color: Constants.iconcolor,
                        ),
                        hintText: "E-Mail",
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Constants.deafultcolor, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Custombuttonsignup("Send", context, () async {
                  if (formkey.currentState!.validate()) {

                  }
                  var ForgotEmail = forgetpasswordcontroller.text.trim();
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: ForgotEmail)
                        .then((value) => {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(alignment: Alignment.center,
                                      backgroundColor: Constants.deafultcolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      content: const Text(
                                        'Email has been sent ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Constants.textcolor,
                                            fontWeight: FontWeight.w500),
                                      ));
                                },
                              ),
                              print('email sent'),
                            });
                  } on FirebaseAuthException catch (e) {
                    print("Error ${e}");

                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
