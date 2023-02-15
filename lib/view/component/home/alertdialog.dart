import 'package:commy/constants.dart';
import 'package:commy/view/pages/setting.dart';
import 'package:commy/view/pages/speachtotext.dart';
import 'package:flutter/material.dart';

Widget AlertdialogFun({required BuildContext context, required String text}) {
  return InkWell(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Constants.textcolor),
      ),
      onTap: () {
        showDialog(
          builder: (context) {
            return AlertDialog(
                title: Text(
                  'Do you want to exit this application?',
                  style: TextStyle(
                      color: Constants.textcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                content: Text(
                  'We hate to see you leave...',
                  style: TextStyle(color: Constants.textcolor, fontSize: 19),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SpeechScreen();
                        },
                      ));
                    },
                    child: Text(
                      'Sure',
                      style: TextStyle(
                          color: Constants.textcolor,
                          fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Setting();
                          },
                        ));
                      },
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Constants.textcolor,
                              fontWeight: FontWeight.bold,fontSize: 20)))
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
