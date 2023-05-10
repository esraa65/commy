import 'package:commy/constants.dart';
import 'package:commy/view/pages/setting.dart';
import 'package:commy/view/pages/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget AlertdialogFun(
    {required BuildContext context, required String text, Icon? icon}) {
  return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 24, color: Constants.textcolor),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Constants.iconcolor,
          )
        ],
      ),
      onTap: () {
        showDialog(
          builder: (context) {
            return AlertDialog(
                title: const Text(
                  'Do you want to exit this application?',
                  style: TextStyle(
                      color: Constants.textcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                content: const Text(
                  'We hate to see you leave...',
                  style: TextStyle(color: Constants.textcolor, fontSize: 19),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                     // FirebaseAuth.instance.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove("email");
                    //  print('alert ${prefs.getString("email").toString()}');
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return  WelcomePage();
                         },
                      ));
                    },
                    child: const Text(
                      'Sure',
                      style: TextStyle(
                          color: Constants.textcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const Setting();
                          },
                        ));
                      },
                      child: const Text('Cancel',
                          style: TextStyle(
                              color: Constants.textcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)))
                ],
                elevation: 24,
                backgroundColor: Constants.deafultcolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)));
          },
          context: context,
        );
      });
}
