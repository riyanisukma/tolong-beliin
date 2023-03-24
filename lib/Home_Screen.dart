import 'package:flutter/material.dart';
import 'package:homescreen/ads_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: GestureDetector(
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdsScreen())
                  );
              },
              child:  Container(
                  height: screen.height,
                  decoration:const BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.bottomCenter,
                          image: AssetImage(
                            'assets/homescreen/Bottom Vector.png',
                          )
                      )
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/homescreen/tolong beliin-3.png',
                      width: screen.width/2,

                    ),

                  )

              ),
            ),


              ),

    );

  }
}



