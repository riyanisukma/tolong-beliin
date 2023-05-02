import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'Forget_password_baru.dart';
import 'component/top/header.dart';
import 'component/utils/primary_button.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
//import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;

import 'homemerchant_screen.dart';


class OtpScreen extends StatefulWidget {
  OtpScreen({required this.username, required this.status});
  String username;
  String status;
 // String iddevicetiga;
  //String kodeotp;
  @override
  OneTimePasswordLayout createState() => OneTimePasswordLayout();
}

class OneTimePasswordLayout extends State<OtpScreen> {
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> otpController;
  bool validateOtp = false;

  String? idDevice;
  void getDeviceIDUsingPlugin() async {
    var device = await PlatformDeviceId.getDeviceId;
    idDevice = device.toString();
  }

  submitForm (nameStoreController,OtpController,context)  async {
    String username = widget.username;
    String? deviceId = idDevice;
    String status = widget.status;

    http.Response response;
    print("tess $deviceId");
    String kodeotp = otpController.map((controller) => controller?.text ?? "").join();
    print(kodeotp);
    if(username.isNotEmpty && kodeotp.isNotEmpty) {
      if(status == 'password') {
         response = await otpPassword(username,deviceId ,kodeotp);
      }
      else {
        response = await otpLogin(username,deviceId ,kodeotp);
      }
      print(response.body);
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
        if(status == 'password') {
          Navigator.push(
          context,
         MaterialPageRoute(builder: (context) =>  ForgetPasswordScreenBaru(username: username,status: "setpassword", iddevice :deviceId, kodeotp : kodeotp)),
        );
        }

        else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  HomeMerchantScreen()),
          );
        }
      }

    }
  }

  Future<http.Response> otpLogin(String fullname, String? idDevice,String kodeotp) {
    return http.post(
      Uri.parse('https://dev.tolongbeliin.com/api/merchant/cekkodeLogin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'fullname': fullname,
        'iddevice' : idDevice,
        'kodeotp': kodeotp,
      }),
    );
  }

  Future<http.Response> otpPassword(String fullname, String? idDevice,String kodeotp) {
    return http.post(
      Uri.parse('https://dev.tolongbeliin.com/api/merchant/lupaPasswordKode'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'fullname': fullname,
        'iddevice' : idDevice,
        'kodeotp': kodeotp,
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    getDeviceIDUsingPlugin();
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
            child: SingleChildScrollView(
              child:  Column(
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
                  const SizedBox(height: 15),
                  OtpTextField(
                    margin: EdgeInsets.fromLTRB(7, 20, 7, 25),
                    numberOfFields: 6,
                    borderWidth: 1,
                    enabledBorderColor:Colors.grey,
                    showFieldAsBox: true,
                    onCodeChanged: (String value) {
                    },
                    handleControllers: (controllers) {
                      otpController = controllers;
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
                  const SizedBox(height: 15),
                  PrimaryButton(
                      text: "Send",
                      width: 200,
                      height: 50,
                      onPressed: () {submitForm("tess", otpController, context);}
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Batas waktu memasukkan kode OTP",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF008037),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CupertinoPageScaffold(
                    child: TimerCountdown(
                      format: CountDownTimerFormat.minutesSeconds,
                      endTime: DateTime.now().add(
                        Duration(
                          minutes: 3,
                          seconds: 0,
                        ),
                      ),
                      onEnd: () {
                        print("Timer finished");
                      },
                    ),
                  )
                ],
              ),
            ),




          ),


        )
    );

  }
}