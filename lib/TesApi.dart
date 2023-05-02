import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:homescreen/login_screen.dart';
void main() async {
  http.Response response = await editMakanan("Yudha","18");

  print(response.body);
}

Future<http.Response> editMakanan(String fullname, String produk_id) {
  return http.post(
    Uri.parse('https://dev.tolongbeliin.com/api/merchant/makanan/delete'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'fullname': fullname,
      'produk_id': produk_id,

    }),
  );
}