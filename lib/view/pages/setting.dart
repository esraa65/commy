import 'package:commy/constants.dart';
import 'package:commy/view/component/home/alertdialog.dart';
import 'package:commy/view/pages/speachtotext.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.deafultcolor,
          elevation: 0,
          title: Text('Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Constants.iconcolor),
          ),
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SpeechScreen();
              },
            ));
          },
            icon:Icon (Icons.arrow_back,color: Constants.iconcolor,),
            color: Constants.deafultcolor,
          ),
        ),
        backgroundColor: Constants.background,
        body: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.all(12.0),
              child: AlertdialogFun(context: context,
                  text: 'Log Out'),

            )
          ],
        ),
      ),
    );
  }

 /* appBar: AppBar(
  backgroundColor: Constants.deafultcolor,
  elevation: 0,
  title: Text('Settings',
  style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 35,
  color: Constants.iconcolor),
  ),
  leading: IconButton(onPressed: (){
  Navigator.push(context, MaterialPageRoute(
  builder: (context) {
  return SpeechScreen();
  },
  ));
  },
  icon:Icon (Icons.arrow_back,color: Constants.iconcolor,),
  color: Constants.deafultcolor,
  ),
  ),
  */
}
