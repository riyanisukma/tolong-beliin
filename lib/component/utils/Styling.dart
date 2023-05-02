import 'package:flutter/material.dart';


class TextFieldStyle{
  static InputDecoration textFieldStyle(
      {String labelTextStr="",String hintTextStr=""})
  {return InputDecoration(
    filled: true,
    fillColor: const Color(0x1F9E9E9E),
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    contentPadding:const EdgeInsets.symmetric(horizontal: 16),
    labelText: labelTextStr,
    hintText:hintTextStr,
    labelStyle: const TextStyle(
      color: Colors.black
    )
  );}

  static InputDecoration textInputMerchant(
      {String labelTextStr="",String hintTextStr=""})
  {return InputDecoration(

      filled: true,
      fillColor: const Color(0xFF008037),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      contentPadding: EdgeInsets.only(top:10,bottom:10),
      hintText:hintTextStr,
      hintStyle: const TextStyle(
            color: Colors.white,
        fontWeight: FontWeight.w300,
          fontSize: 9,


      ),
  );}
}


