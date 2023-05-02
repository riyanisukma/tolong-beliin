import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homescreen/component/layout/ListItem_store_component.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:homescreen/component/utils/Form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homescreen/component/utils/API_Utils.dart';
import '../utils/Styling.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class EditProductComponent extends StatefulWidget {
  EditProductComponent({ required this.editProduct,required this.storeForm});
  ProductForm editProduct;
  StoreForm storeForm;
  @override
  _EditProductComponent createState() => _EditProductComponent();
}

class _EditProductComponent extends State<EditProductComponent> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  ProductForm formProduct = ProductForm();
  StoreForm formStore = StoreForm();
  ApiUtils utils = ApiUtils();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    File? file = File(img!.path);
    setState(() {
      image = img;
    });
    formProduct.photo = file;
  }

  void downloadImage(String? url) async{
    final http.Response responseData = await http.get(Uri.parse("$url"));
    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    XFile xfile = new XFile(file.path);
    setState(() {
      image = xfile;
    });
  }
  void saveData(StoreForm store, ProductForm product) {
    utils.editProduct(store, product);
  }
   deleteData(StoreForm store, ProductForm product, context) async {
    String fullname = store.fullname.toString();
    String productId = product.idProduct.toString();
    print(fullname);
    print(productId);
    http.Response respon = await utils.deleteMakanan(fullname, productId);
    if(respon.statusCode == 200){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Berhasil menghapus produk"),
            );

          }
      );
    }
    else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Gagal menghapus produk"),
            );

          }
      );
    }
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


  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    String? imageSrc = widget.editProduct!.photoSrc;
    String categoryName = "makanan";
    formStore = widget.storeForm!;
    String? stock = widget.editProduct.stock;
    setState(() {
        formProduct = widget.editProduct;
    });
    void setForm(value, param) {
      if (param == "name") {
        formProduct.name = value;
      } else if (param == "category") {
        formProduct.category = value;
      } else if (param == "price") {
        formProduct.price = value;
      } else if (param == "stock") {
        formProduct.stock = value;
      }
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
                      ? Image.file(
                     File(formProduct.photo!.path),
                    fit: BoxFit.cover,
                    width: 55,
                    height: 45,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 25,
                      child: TextFormField(
                        initialValue: widget.editProduct!.name,
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
                      children: [
                        SizedBox(
                          width: 75,
                          height: 20,
                          child: TextFormField(
                            initialValue: widget.editProduct!.price,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 13),
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
                            initialValue: widget.editProduct!.category,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 13),
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
            Column(

              children: [
                SizedBox(
                  width: 30,
                  height: 25,
                  child: TextFormField(
                    initialValue: "$stock",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.center,
                    decoration: TextFieldStyle.textInputMerchant(
                        hintTextStr: "Stok"),
                    onChanged: (value) => setForm(value, "stock"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Stok tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    PrimaryButton(text: "Save",fontSize: 8, width: 20, height: 20, onPressed: () {saveData(formStore, formProduct);}, ),
                    PrimaryButton(text: "Del",fontSize: 8, width: 20, height: 20, onPressed: () {deleteData(formStore, formProduct , context);} ),

                  ],
                )
              ],
            ),

          ],
        ));
  }
}
