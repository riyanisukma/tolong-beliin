import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:homescreen/Edit_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'component/layout/Listitem_dashboard_component.dart';
import 'package:homescreen/component/top/header.dart';
import 'package:homescreen/component/top/header_merchant.dart';
import 'package:homescreen/component/utils/Form.dart';
import 'package:homescreen/component/utils/primary_button.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'component/utils/API_Utils.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key, required this.data});
  final List<dynamic> data;
  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

class _ProductListScreen extends State<ProductListScreen> {
  StoreForm storeForm = StoreForm();
  String fullname = "Yudha";
  ApiUtils utils = ApiUtils();

  List<ProductForm> listProduct = [];
  List<dynamic> dataMerchant=[];

  Future<File>downloadImage(String? url) async{
    final http.Response responseData = await http.get(Uri.parse("$url"));
    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    String fileName = url!.split('/').last;
    File file = await File('${tempDir.path}/$fileName').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }
   Future fillData() async{
      storeForm.name = dataMerchant[0]['nama_toko'];
      storeForm.address = dataMerchant[0]['alamat_toko'];
      storeForm.photoSrc = dataMerchant[0]['foto_toko'];
      storeForm.fullname = "Yudha";
      storeForm.storeId = dataMerchant[0]['id_toko'];
      storeForm.photo = await downloadImage(storeForm.photoSrc);
      for(int i= 0; i< dataMerchant.length; i++) {
        ProductForm productForm = ProductForm();
        productForm.name = dataMerchant[i]['produk_nama'];
        productForm.price = dataMerchant[i]['produk_harga'];
        productForm.stock = dataMerchant[i]['produk_stok'].toString();
        productForm.photoSrc = dataMerchant[i]['produk_foto'];
        productForm.idProduct = dataMerchant[i]['produk_id'];
        productForm.category = dataMerchant[i]['produk_kategori_nama'];
        productForm.categoryId = dataMerchant[i]['produk_kategori_id'].toString();
        productForm.photo = await downloadImage(productForm.photoSrc);
        listProduct.add(productForm);
      }

  }

  @override
  Widget build(BuildContext context) {
     dataMerchant = widget.data;
    listProduct = [];
    fillData();

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
                    onPressed: () {},
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(children: [
                Container(
                    width: double.infinity,
                    height: screen.height / 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        dataMerchant[1]['nama_toko'],
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    )),
                SizedBox(height: 25),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 25),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/Merchant/avatar-gamer.png',
                                  fit: BoxFit.scaleDown,
                                  scale: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(fullname),
                                    Text(dataMerchant[0]['alamat_toko'])
                                  ],
                                )
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.5, color: Color(0xFFDDDDDD)))),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.store,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Informasi Toko",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.5, color: Color(0xFFDDDDDD)))),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.rectangle_outlined,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Area District",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.5, color: Color(0xFFDDDDDD)))),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.motorcycle_sharp,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Delivery Toko",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 245,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: dataMerchant.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ListItemDashboard(
                            productImage: dataMerchant[index]['produk_foto'],
                            productName: dataMerchant[index]['produk_nama'],
                            productStock: dataMerchant[index]['produk_stok'],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {Navigator.push(context,
                       MaterialPageRoute(builder: (context) => EditProductScreen(listProduct: listProduct,store: storeForm)));},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: Size.zero,
                          ),
                          child: Text(
                            "Edit",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                )
              ]),
            )));
  }
}
