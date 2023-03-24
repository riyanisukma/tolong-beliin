import 'package:flutter/material.dart';

class HeaderMerchant extends StatelessWidget implements  PreferredSizeWidget{
  const HeaderMerchant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return  AppBar(
          backgroundColor: Colors.green,
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(Icons.person),
          ),
          elevation: 0,
          title: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Hello, Mike!",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Welcome back to your account",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300
                    ),
                  )
                ],
              )
            ],


          ),

        )

     ;
  }




  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}