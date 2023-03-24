import 'package:flutter/material.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:homescreen/component/utils/text_input_bg_grey.dart';

import 'OTP_Layout.dart';
import 'component/top/header.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const HeaderTitle(
            headerTitle: "Sign Up"
        ),
        body: Container(
          height: screen.height,
            decoration:const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage(
                      'assets/homescreen/Bottom Vector Ads.png',
                    )
                )
            ),
          margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: SingleChildScrollView(
               child:  Column(
                children: [
                  Image.asset(
                    'assets/homescreen/tolong beliin-3.png',
                    height: screen.height/6,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text(

                            "Merchant",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const FormInput(
                          hintText: "Full Name / Merchant",
                          password: false,
                        ),
                        const SizedBox(height: 20),
                        const FormInput(
                          hintText: "Email/ number phone",
                          password: false,
                        ),
                        const SizedBox(height: 20),
                        const FormInput(
                            hintText: "Password",
                            password: true
                        ),
                        const SizedBox(height: 20),
                        const FormInput(
                            hintText: "Code referal",
                            password: false
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                            text: "Sign in",
                            width: screen.width,
                            height: 40,
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  VerificationScreen1()),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

        ),
      ),
    );
  }
}
