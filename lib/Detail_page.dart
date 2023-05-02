import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homescreen/component/top/header.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:http/http.dart' as http;

import 'OTP_Layout.dart';


class DetailPage extends StatelessWidget {


  DetailPage({required this.fullname, required this.userpass, required this.emailphone});

  String fullname;
  String userpass;
  String emailphone;

  Future<http.Response> createUser(String fullname, String userpass, String emailphone) {
    return http.post(
      Uri.parse('https://dev.tolongbeliin.com/api/merchant/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'fullname': fullname,
        'userpass': userpass,
        'emailphone': emailphone,
      }),
    );
  }
  sendData(context) async {
    http.Response response = await createUser(fullname, userpass,emailphone );
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  OtpScreen(username: fullname, status: "signIn")),
        );
      }
  }


  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const HeaderTitle(headerTitle: "Detail Page"),
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
            child: Center(
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/homescreen/tolong beliin-3.png',
                    height: screen.height/5,
                  ),
                  const SizedBox(height: 20,),
                  const Text("Verify Your Data",
                  style: TextStyle(
                    color: Color(0xFF008134),
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  const SizedBox(height: 30),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Fullname",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Text("Email/phone",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(": $fullname",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),),
                          Text(": $emailphone",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),),

                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 90),
                  PrimaryButton(text: "Submit",
                    width: 80,
                    height: 30,
                    onPressed: () {
                      sendData(context);
                    },
                  )
                ],
              ),
            ),


      ),
    );
  }
}