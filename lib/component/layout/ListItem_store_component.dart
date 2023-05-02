import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:homescreen/component/utils/Form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homescreen/component/utils/API_Utils.dart';
import '../utils/Styling.dart';
import 'package:http/http.dart' as http;

typedef void FormProduct(ProductForm form);

class ListItemComponent extends StatefulWidget {
  ListItemComponent({required this.formProduct});
  final FormProduct formProduct;

  @override
  _ListItemComponent createState() => _ListItemComponent();
}

class _ListItemComponent extends State<ListItemComponent> {
  int count = 0;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  ProductForm form = ProductForm();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    File? file = File(img!.path);
    print("INI DIA $file");
    setState(() {
      image = img;
    });
    form.photo = file;
    widget.formProduct(form);
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Pilih gambar yang akan ditampilkan'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008037),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        SizedBox(width: 15),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008037),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        SizedBox(width: 15),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addItem() {
    setState(() {
      count++;
      form.stock = count.toString();
      widget.formProduct(form);
    });
  }

  void reduceItem() {
    if (count > 0) {
      setState(() {
        count--;
        form.stock = count.toString();
        widget.formProduct(form);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    String categoryName = "makanan";

    void setForm(value, param) {
      print(value);
      if (param == "name") {
        form.name = value;
      } else if (param == "category") {
        form.category = value;
      } else if (param == "price") {
        form.price = value;
      }
      widget.formProduct(form);
    }

    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(1, 2),
                        blurRadius: 7,
                      )
                    ]),
                child: GestureDetector(
                  onTap: myAlert,
                  child: image == null
                      ? Image.asset(
                          'assets/Merchant/upload_icon.png',
                          fit: BoxFit.fill,
                          scale: 9,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: 55,
                            height: 45,
                          ),
                        ),
                )),
            Expanded(
                child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 25,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center,
                    decoration: TextFieldStyle.textInputMerchant(
                        hintTextStr: "NAMA $categoryName"),
                    onChanged: (value) => setForm(value, "name"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama produk tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 75,
                      height: 20,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: TextFieldStyle.textInputMerchant(
                            hintTextStr: "Harga"),
                        onChanged: (value) => setForm(value, "price"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Harga tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      height: 20,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: TextFieldStyle.textInputMerchant(
                            hintTextStr: "Kategori"),
                        onChanged: (value) => setForm(value, "category"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kategori tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
            SizedBox(
              width: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.symmetric(vertical: 1)),
                    onPressed: reduceItem,
                    child: Text(
                      "-",
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
                    child: Text("$count", textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                      onPressed: addItem,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.symmetric(vertical: 1)),
                      child: Text(
                        "+",
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
        ));
  }
}
