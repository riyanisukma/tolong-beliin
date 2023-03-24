import 'package:flutter/material.dart';



class HeaderTitle extends StatelessWidget implements  PreferredSizeWidget{
  const HeaderTitle({
    super.key,
    required this.headerTitle,
  });
  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return  AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            headerTitle,
            style: const TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}