
import 'package:flutter/material.dart';
import 'component/top/header.dart';
import 'component/utils/primary_button.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


class VerificationScreen1 extends StatefulWidget {
  @override
  OneTimePasswordLayout createState() => OneTimePasswordLayout();
}

class OneTimePasswordLayout extends State<VerificationScreen1> {
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
            appBar: const HeaderTitle(
                headerTitle: "OTP Verificator"
            ),
            body: Container(
              height: double.infinity,
              decoration:const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      image: AssetImage(
                        'assets/homescreen/Bottom Vector Ads.png',
                      )
                  )
              ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Image.asset(
                        'assets/homescreen/tolong beliin-3.png',
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(height: 25),
                      const Text(
                        "Insert OTP Passcode",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      OtpTextField(
                        margin: EdgeInsets.fromLTRB(7, 20, 7, 25),
                        numberOfFields: 6,
                        borderWidth: 1,
                        enabledBorderColor:Colors.black,
                        showFieldAsBox: true,
                        onCodeChanged: (String value) {
                        },
                        handleControllers: (controllers) {
                          controls = controllers;
                        },
                        onSubmit: (String verificationCode) {
                          setState(() {
                            var clearText = false;
                          });
                          //navigate to different screen code goes here
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Verification Code"),
                                content: Text('Code entered is $verificationCode'),
                              );
                            },
                          );
                        }, // end onSubmit
                      ),
                      PrimaryButton(
                          text: "Send",
                          width: 200,
                          height: 50,
                          onPressed: () {}
                      ),

                    ],
                  ),




            ),


        )
    );

  }
}

