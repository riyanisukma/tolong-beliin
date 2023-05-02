import 'package:flutter/material.dart';
import 'package:homescreen/Product_list_screen.dart';
import 'package:homescreen/component/utils/API_Utils.dart';
import 'package:homescreen/login_screen.dart';

import 'component/top/header.dart';
import 'component/utils/primary_button.dart';

class ProductLoadScreen extends StatefulWidget {
  ProductLoadScreen({Key? key}) : super(key: key);

  @override
  State<ProductLoadScreen> createState() => _ProductLoadScreen();
}

class _ProductLoadScreen extends State<ProductLoadScreen> {
  ApiUtils utils = ApiUtils();
  String fullname= "Yudha";


  @override
  Widget build(BuildContext context) {
    List<dynamic> dataMerchant =[];
    void skip(context) {
      if(dataMerchant.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductListScreen(data: dataMerchant)),
        );
      }
    }
    Size screen = MediaQuery.of(context).size;
    utils.getProduct(fullname).then((value) {
      dataMerchant = value.toList();
    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: const HeaderTitle(
                headerTitle: "Login"
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              decoration:const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      image: AssetImage(
                        'assets/homescreen/Bottom Vector Ads.png',
                      )
                  )
              ),
              child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/homescreen/tolong beliin-3.png',
                        height: screen.height/3.5 ,

                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 40, 0, 80),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 128, 55, 80),
                                ),
                                children: [
                                  TextSpan(
                                      text: "Your selling one app \n \n",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27,
                                        letterSpacing: -0.7,
                                        wordSpacing: 1,
                                      )
                                  ),
                                  TextSpan(
                                      text: "Everything that you need to \n"
                                          "know about your setting is now here. \n"
                                          "All the information in one app",
                                      style: TextStyle(
                                        fontSize: 18,
                                      )
                                  )
                                ]
                            ),
                          )
                      ),
                      PrimaryButton(
                          text: "Skip",
                          height: 23,
                          width: 110,
                          onPressed: (){
                            skip(context);
                          }
                      ),

                    ],
                  )
              ),
            )
        )
    );

  }
}




