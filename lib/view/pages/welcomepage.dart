import 'package:commy/constants.dart';
import 'package:commy/view/pages/login.dart';
import 'package:commy/view/pages/signup.dart';
import 'package:flutter/material.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

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
              child:
              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Let's Commy ",
                          style: TextStyle(color: Constants.textcolor,fontSize: 24,
                            fontWeight: FontWeight.bold),),
                      ),
                    ],

                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Constants.deafultcolor),
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
                              style: TextStyle(color: Constants.textcolor),
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
                    child:  ElevatedButton(
                      style: ElevatedButton.styleFrom( shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Constants.background),
                      autofocus: true,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Signup();
                          },
                        ));
                      },
                      child: Container(
                        width: size.width*0.6,
                        height: size.height*0.06,
                        child: Center(child: Text('SignUp',style: TextStyle(color: Constants.deafultcolor),)),
                      ),
                    ),
                  )
                ],
              ),

            )],),
          ),
        ),
      ),
    );
  }
}
