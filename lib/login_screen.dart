import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homescreen/Forget_password.dart';
import 'package:homescreen/OTP_Layout.dart';
import 'package:homescreen/component/top/header.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:homescreen/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final TextEditingController nameStoreController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool validateNameStore = false;
  bool validatePassword = false;

  String? idDevice;
  void getDeviceIDUsingPlugin() async {
    var device = await PlatformDeviceId.getDeviceId;
    idDevice = device.toString();
  }

   submitForm (nameStoreController,passwordController,context)  async {
    String username = nameStoreController.text;
    String password = passwordController.text;
    String? deviceId = idDevice;
    setState(() {
      username.isEmpty ? validateNameStore = true  : validateNameStore = false;
      password.isEmpty ? validatePassword = true  : validatePassword = false;
    });
    if(username.isNotEmpty && password.isNotEmpty) {
      http.Response response = await loginUser(username, password);
      final data = json.decode(response.body);
      if(data['status'].toString() == 'false') {
        String errorMessage = data['message'];
        showDialog(
            context: context,
            builder: (context) {
            return AlertDialog(
              content: Text(errorMessage),
            );
        }
        );
      }
      else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  OtpScreen(username: username, status: "login")),
        );
      }

    }
  }

  Future<http.Response> loginUser(String fullname, String userpass) {
    return http.post(
      Uri.parse('https://dev.tolongbeliin.com/api/merchant/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': fullname,
        'userpass': userpass,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    getDeviceIDUsingPlugin();
    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HeaderTitle(
            headerTitle: "Login",
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
                  height: 200,
                  width: 200,
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
                            'Name Store',
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: nameStoreController,
                        decoration: InputDecoration(
                          errorText:  validateNameStore ? "Enter your name store" : null,
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12
                              )
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12
                              )
                          ),
                          hintText: "Enter name store",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child:  Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                              fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:  InputDecoration(
                          errorText: validatePassword ? "Enter your password" : null ,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black12
                            )
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12
                              )
                          ),
                          hintText: "Enter Password",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 15),
                      PrimaryButton(
                          text: "Login",
                          width: screen.width,
                          height: 40,
                        onPressed: () {
                            submitForm(nameStoreController,passwordController,context);
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,

                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "If you don't have an account?",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  SignInScreen()),
                                          );
                                        },
                                        child: const Text(
                                          "Sign up",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                    ),
                                  ]
                              ),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  ForgetPasswordScreen()),
                                  );
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),


                          ],
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

