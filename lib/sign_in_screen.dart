import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:homescreen/component/utils/text_input_bg_grey.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'Detail_page.dart';
import 'OTP_Layout.dart';
import 'component/top/header.dart';
import 'component/utils/Styling.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController nameStoreController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailphoneController = TextEditingController();
  final TextEditingController kodereferalController = TextEditingController();
  bool validateNameStore = false;
  bool validatePassword = false;
  bool validateEmailphone = false;

  String? idDevice;
  void getDeviceIDUsingPlugin() async {
    var device = await PlatformDeviceId.getDeviceId;
    idDevice = device.toString();
  }

  submitForm (nameStoreController,passwordController, emailphoneController, kodereferralController, context)  async {
    String username = nameStoreController.text;
    String password = passwordController.text;
    String emailphone = emailphoneController.text;
    String kodereferal = kodereferalController.text;
    String deviceId = idDevice.toString();
    setState(() {
      username.isEmpty ? validateNameStore = true  : validateNameStore = false;
      password.isEmpty ? validatePassword = true  : validatePassword = false;
      emailphone.isEmpty ? validateEmailphone = true  : validateEmailphone = false;
    });
    if(username.isNotEmpty && password.isNotEmpty && emailphone.isNotEmpty) {
      http.Response response = await createUser(username, password, emailphone/*, kodereferal, deviceId*/);
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
          MaterialPageRoute(builder: (context) =>  OtpScreen(username: username, status: "SignUp")),
        );
      }

    }
  }

  Future<http.Response> createUser(String fullname, String userpass, String emailphone/*, String kodereferal, String idDevice*/) {
    return http.post(
      Uri.parse('https://dev.tolongbeliin.com/api/merchant/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': fullname,
        'userpass': userpass,
        'emailphone': emailphone,
       /* 'kodereferal': kodereferal,
        'iddevice' : idDevice,*/
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
            headerTitle: "Sign Up"
        ),
        body: Form(
          //key: _formKey,
          child:  Container(
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
                  mainAxisSize: MainAxisSize.max,
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
                          TextFormField(
                            decoration: TextFieldStyle.textFieldStyle(
                                hintTextStr: "Full Name / Merchant",
                                labelTextStr: "Full Name / Merchant"
                            ),
                            controller: nameStoreController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama toko tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailphoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email/phonetidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: TextFieldStyle.textFieldStyle(
                                hintTextStr: "Email / Phone number",
                                labelTextStr: "Email / Phone number"
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: TextFieldStyle.textFieldStyle(
                                hintTextStr: "Password",
                                labelTextStr: "Password"
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: TextFieldStyle.textFieldStyle(
                                hintTextStr: "Retype Password",
                                labelTextStr: "Retype Password"
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: kodereferalController,
                            decoration: TextFieldStyle.textFieldStyle(
                                hintTextStr: "Code Referral",
                                labelTextStr: "Code Referral"
                            ),
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            text: "Sign in",
                            width: screen.width,
                            height: 40,
                            onPressed: () {
                                submitForm(nameStoreController,passwordController,emailphoneController, kodereferalController, context);

                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )

          ),
        ),
      ),
    );
  }
}
