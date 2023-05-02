import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:homescreen/component/top/header.dart';
import 'package:homescreen/component/top/header_merchant.dart';
import 'package:homescreen/component/utils/Form.dart';
import 'package:homescreen/component/utils/primary_button.dart';

import 'component/bottom/footer_navigation.dart';
import 'component/layout/Group_of_list_component.dart';
import 'component/layout/ListItem_store_component.dart';
import 'component/layout/Register_Store_Component.dart';
import 'component/utils/API_Utils.dart';

class FoodMerchantScreen extends StatefulWidget {
  FoodMerchantScreen({super.key});

  @override
  State<FoodMerchantScreen> createState() => _FoodMerchantScreen();
}

class _FoodMerchantScreen extends State<FoodMerchantScreen> {
  StoreForm storeForm = StoreForm();
  ProductForm productForm = ProductForm();
  String fullname = "Anggi";
  ApiUtils utils = ApiUtils();
//STORE
  void getFormStore(StoreForm form) {
    setState(() {
      storeForm = form;
    });
  }

  //Produk
  void getFormProduct(ProductForm form) {
    setState(() {
      productForm = form;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: HeaderMerchant(
            fullname: fullname,
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: screen.height,
            width: screen.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: AssetImage(
                      'assets/Merchant/bottom_1.png',
                    ),
                    fit: BoxFit.scaleDown,
                    scale: 2.5)),
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryButton(
                        text: "MASUKAN DATA USAHA ANDA",
                        width: 100,
                        height: 30,
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          utils.getProduct(fullname);
                        }),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(color: Colors.white),
                        height: 70,
                        width: 150,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: null,
                              iconSize: 50,
                              icon: Image.asset(
                                "assets/Merchant/Food.png",
                              ),
                            ),
                            Text("Makanan & \n Minuman")
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 0),
                              blurRadius: 7,
                            )
                          ]),
                      child: RegisterComponent(
                        getFormStore: (addForm) {
                          getFormStore(addForm);
                        },
                      ),
                    ),
                    ListItemComponent(
                      formProduct: (form) {
                        getFormProduct(form);
                      },
                    ),
                    FooterNavigation(
                      productForm: productForm,
                      storeForm: storeForm,
                      fullname: fullname,
                    )
                  ],
                )),
          ),
        ));
  }
}
