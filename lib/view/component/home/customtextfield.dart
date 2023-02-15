import 'package:commy/constants.dart';
import 'package:flutter/material.dart';

Widget Customtextform(String word, {Icon? icon}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: TextFormField(
      decoration: InputDecoration(
          suffixIcon: icon ?? null,
          hintText: word,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Constants.deafultcolor, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          )),
    ),
  );
}
