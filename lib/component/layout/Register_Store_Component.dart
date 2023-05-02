import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homescreen/component/utils/Form.dart';
import 'package:homescreen/component/utils/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../utils/API_Utils.dart';
import '../utils/Styling.dart';

typedef void FormStore(StoreForm addForm);

class RegisterComponent extends StatefulWidget {
  RegisterComponent({super.key, required this.getFormStore});
  final FormStore getFormStore;

  @override
  _RegisterComponent createState() => _RegisterComponent();
}

class _RegisterComponent extends State<RegisterComponent> {
  var apiUtils = ApiUtils();
  XFile? image;
  final ImagePicker picker = ImagePicker();
  StoreForm form = StoreForm();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    File file = File(img!.path);
    print("INI DIA $file");
    setState(() {
      image = img;
    });
    form.photo = file;
    widget.getFormStore(form);
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
    void setForm(value, param) {
      if (param == "name") {
        form.name = value;
      } else if (param == "address") {
        form.address = value;
      } else if (param == "photo") {
        form.photo = value;
      }
      widget.getFormStore(form);
    }

    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
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
                    ? Column(
                        children: [
                          Image.asset(
                            'assets/Merchant/upload_icon.png',
                            fit: BoxFit.scaleDown,
                            scale: 9,
                          ),
                          SizedBox(height: 5),
                          Text("Upload")
                        ],
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
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 20,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: TextFieldStyle.textInputMerchant(
                        hintTextStr: "TULIS NAMA TOKO"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama toko tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setForm(value, "name");
                    },
                  ),
                ),
                SizedBox(height: 7),
                SizedBox(
                  width: 200,
                  height: 20,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: TextFieldStyle.textInputMerchant(
                        hintTextStr: "ALAMAT TOKO"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Alamat toko tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) => setForm(value, "address"),
                  ),
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                      textAlign: TextAlign.start,
                      text: "ORGANIK",
                      width: 50,
                      height: 20,
                      fontSize: 8,
                      fontWeight: FontWeight.w300,
                      onPressed: () {
                        print(form.name);
                      },
                    ),
                    PrimaryButton(
                      textAlign: TextAlign.start,
                      text: "IMPORT",
                      width: 50,
                      height: 20,
                      fontSize: 8,
                      fontWeight: FontWeight.w300,
                      onPressed: () {
                        print(form.address);
                      },
                    ),
                    PrimaryButton(
                      text: "LOKAL",
                      fontSize: 8,
                      width: 50,
                      height: 20,
                      fontWeight: FontWeight.w300,
                      onPressed: () {},
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
