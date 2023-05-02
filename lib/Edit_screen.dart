import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:homescreen/Food_screen.dart';
import 'package:homescreen/component/top/header.dart';
import 'package:homescreen/component/top/header_merchant.dart';
import 'package:homescreen/component/utils/Form.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:image_picker/image_picker.dart';

import 'component/bottom/footer_navigation.dart';
import 'component/layout/Edit_product_component.dart';
import 'component/layout/Group_of_list_component.dart';
import 'component/layout/ListItem_store_component.dart';
import 'component/layout/Register_Store_Component.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'component/utils/API_Utils.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({ required this.listProduct, required this.store});
  List<ProductForm> listProduct;
  StoreForm store;
  @override
  State<EditProductScreen> createState() => _EditProductScreen();
}

class _EditProductScreen extends State<EditProductScreen> {
  StoreForm storeForm = StoreForm();
  ProductForm productForm = ProductForm();
  ApiUtils utils = ApiUtils();
  List<ProductForm> edited = [];





  @override
  Widget build(BuildContext context) {
    storeForm = widget.store;

    Size screen = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FoodMerchantScreen()));},
                ),
                Text(
                  "Back",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            backgroundColor: Colors.green,
            elevation: 0,
            leadingWidth: 100,
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: screen.height,
            width: screen.width,
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 500,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.listProduct.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductForm edit = ProductForm();
                            edit = widget.listProduct[index];
                            return EditProductComponent(
                              editProduct: edit,
                              storeForm: storeForm,
                            );
                          }),
                  ),
                    SizedBox(height: 30,),
                  ],
                )),
          ),
        ));
  }
}
