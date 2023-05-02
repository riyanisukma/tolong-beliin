import 'package:flutter/material.dart';



class HeaderMerchant extends StatelessWidget implements PreferredSizeWidget {
  const HeaderMerchant({
    super.key, required this.fullname,
  });
  final String fullname;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/Merchant/headerMerchant.png',
          ),
          fit: BoxFit.cover,
        )),
        child: AppBar(
          leading: const CircleAvatar(
            backgroundImage: AssetImage(
              'assets/Merchant/avatar-gamer.png',
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Hello, $fullname!",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Welcome back to your account",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(115);
}
