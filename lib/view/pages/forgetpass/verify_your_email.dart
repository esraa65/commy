import 'package:commy/constants.dart';
import 'package:commy/view/component/home/custombuttonsignup.dart';
import 'package:commy/view/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationScreen extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();

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
              "Verfiy Your E-mail ",
              style: TextStyle(
                fontSize: 19,
                color: Constants.textcolor,
                fontWeight: FontWeight.w500,
              ),
            )),
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/photo_2023-05-04_22-14-29.jpg",
                  fit: BoxFit.fill),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              const Text(
                textAlign: TextAlign.center,
                "please enter the 4-digit code sent to ",
                style: TextStyle(
                  color: Constants.textcolor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 43,
              ),
              const Text(
                textAlign: TextAlign.center,
                "esraa@gmail.com",
                style: TextStyle(
                  color: Constants.deafultcolor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 45,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Constants.deafultcolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(fontSize: 30),
                          decoration: InputDecoration(border: InputBorder.none),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                    Container(
                        width: 45,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Constants.deafultcolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(fontSize: 30),
                          decoration: InputDecoration(border: InputBorder.none),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                    Container(
                        width: 45,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Constants.deafultcolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(fontSize: 30),
                          decoration: InputDecoration(border: InputBorder.none),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                    Container(
                        width: 45,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Constants.deafultcolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(fontSize: 30),
                          decoration: InputDecoration(border: InputBorder.none),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 56,
                child:Custombuttonsignup("Verify", context, () {

                })
                  
              ),
            ],
          ),
        ),
      ),
    );
  }
}
