import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListItemDashboard extends StatelessWidget {
  ListItemDashboard(
      {required this.productImage,
      required this.productName,
      required this.productStock});
  final String productImage;
  final String productName;
  final int productStock;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                productImage,
                fit: BoxFit.cover,
                width: 75,
                height: 75,
              ),
            ),
          ),
          Container(
              width: screen.width / 3,
              margin: EdgeInsets.only(left: 10, right: 15),
              padding: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  productName,
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              )),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.symmetric(vertical: 1)),
                  onPressed: () {},
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text("$productStock", textAlign: TextAlign.center),
                ),
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.symmetric(vertical: 1)),
                    child: Text(
                      "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
