import 'package:commy/constants.dart';
import 'package:flutter/material.dart';

Widget CustombuttonLogin(String text, BuildContext context,{Function ?function}) {
  Size size = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Constants.deafultcolor),
      autofocus: true,
      onPressed: () {
       function;
      },
      child: Container(
        width: size.width * 0.6,
        height: size.height * 0.06,
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Constants.textcolor),
        )),
      ),
    ),
  );

}
