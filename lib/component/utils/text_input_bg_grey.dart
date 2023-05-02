import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.hintText,
    required this.password,
    required this.controller,
    this.validator,
  });
  final String hintText;
  final bool password;
  final TextEditingController controller;
  final Function? validator;

  @override
  Widget build(BuildContext context) {

    return  TextFormField(
      obscureText: password,
      controller: controller,
      validator: (value) {validator;},
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0x1F9E9E9E),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        hintText: hintText,
        contentPadding:const EdgeInsets.symmetric(horizontal: 16),
      ),
    );

  }
}