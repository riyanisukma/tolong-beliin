
import 'package:flutter/material.dart';
import 'package:homescreen/OTP_Layout.dart';

import '../../sign_in_screen.dart';

class PrimaryButton extends StatelessWidget {
   PrimaryButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
    this.fontSize,
     this.fontWeight,
     this.textAlign

  });
  final String text;
  final double width;
  final double height;
  final Function onPressed;
   double? fontSize = 16;
   FontWeight? fontWeight = FontWeight.w500;
  TextAlign? textAlign = TextAlign.center;

  @override
  Widget build(BuildContext context) {

    return  ElevatedButton(

      style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size(width,height),
          backgroundColor: const Color(0xFF008037),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),

      ),
      onPressed: () {onPressed();},
      child: Text(
        text,
        textAlign: textAlign,
        style:  TextStyle(
            color: Colors.white,
            fontWeight: fontWeight,
            fontSize: fontSize,

        ),
      ),
    );
  }

}