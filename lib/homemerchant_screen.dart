import 'dart:math';

import 'package:flutter/material.dart';
import 'package:homescreen/component/top/header.dart';
import 'package:homescreen/component/top/header_merchant.dart';
import 'package:homescreen/component/utils/primary_button.dart';

class HomeMerchantScreen extends StatelessWidget {
  const HomeMerchantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fullname = "Anggi";
    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: HeaderMerchant(fullname: fullname),
            body: Container(
              margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.bottomRight,
                      image: AssetImage(
                        'assets/Merchant/bottom_1.png',
                      ),
                      fit: BoxFit.scaleDown,
                      scale: 2.5)),
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Center(
                    child: Column(
                  children: [
                    Image.asset(
                      'assets/homescreen/tolong beliin-3.png',
                      height: screen.height / 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                            text: "PILIH JENIS USAHA",
                            width: 100,
                            height: 30,
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            onPressed: () {}),
                        PrimaryButton(
                            text: "ACCOUNT MERCHANT",
                            width: 100,
                            height: 30,
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            onPressed: () {})
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: 70,
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  iconSize: 50,
                                  icon: Image.asset(
                                    "assets/Merchant/Food.png",
                                  ),
                                ),
                                Text("Makanan & \n Minuman")
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: 70,
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  iconSize: 50,
                                  icon: Image.asset(
                                    "assets/Merchant/vegetable.png",
                                  ),
                                ),
                                Text("Buah & \n Sayur")
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: 70,
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  iconSize: 50,
                                  icon: Image.asset(
                                    "assets/Merchant/Electrical.png",
                                  ),
                                ),
                                Text("Electronic \n & Minuman")
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: 70,
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  iconSize: 50,
                                  icon: Image.asset(
                                    "assets/Merchant/car-service.png",
                                  ),
                                ),
                                Text("Otomotif")
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: 70,
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  iconSize: 50,
                                  icon: Image.asset(
                                    "assets/Merchant/pharmacy.png",
                                  ),
                                ),
                                Text("Pharmacy")
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: 70,
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  iconSize: 50,
                                  icon: Image.asset(
                                    "assets/Merchant/Fashion.png",
                                  ),
                                ),
                                Text("Fashion & \n Hobby")
                              ],
                            )),
                      ],
                    ),
                  ],
                )),
              ),
            )));
  }
}
