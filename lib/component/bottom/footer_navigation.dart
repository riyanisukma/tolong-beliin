import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homescreen/component/utils/API_Utils.dart';

import '../utils/Form.dart';

class FooterNavigation extends StatelessWidget {
  FooterNavigation({required this.storeForm, required this.productForm, required this.fullname});
  //TOKO
  final StoreForm storeForm;
  final ProductForm productForm;
  final String fullname;
  @override
  Widget build(BuildContext context) {
    var apiUtils = ApiUtils();

    sendData() {
      apiUtils.addProduct(storeForm, productForm, fullname);
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 4, 25, 4),
                  decoration: BoxDecoration(
                      color: Color(0xFF008037),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "PAGE 1",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                          minimumSize: Size.zero),
                      child: Text(
                        "2",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    shadowColor: Color(0),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 25,
                      ),
                      Text(
                        "KEMBALI",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(bottom: 7),
                child: ElevatedButton(
                  onPressed: () {
                    sendData();
                  },
                  child: Text(
                    "SELESAI",
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    minimumSize: Size.zero,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
