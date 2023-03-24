import 'package:flutter/material.dart';
import 'package:homescreen/OTP_Layout.dart';
import 'package:homescreen/component/top/header.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:homescreen/sign_in_screen.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HeaderTitle(
          headerTitle: "Forget Pssword",
        ),
        body: Container(
          decoration:const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(
                    'assets/homescreen/Bottom Vector Ads.png',
                  )
              )
          ),
          margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/homescreen/tolong beliin-3.png',
                  height: 300,
                  width: 300,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child:  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter your name store:',
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12
                              )
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12
                              )
                          ),
                          hintText: "Enter name store",
                          hintStyle:  TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 15),
                      PrimaryButton(
                          text: "Reset Password",
                          width: screen.width,
                          height: 40,
                          onPressed: (){}
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
