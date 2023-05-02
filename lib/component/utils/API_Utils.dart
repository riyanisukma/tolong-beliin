import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

import 'Form.dart';

class ApiUtils {
  void addProduct(StoreForm store, ProductForm product, String fullName) async {
    try {
      //STORE
      String? storeName = store.name;
      String? storeAddress = store.address;
      File? storePhoto = store.photo;

      //PRODUCT
      String? productName = product.name;
      String? productPrice = product.price;
      String? productCategory = product.category;
      String? productStock = product.stock;
      File? productPhoto = product.photo;

      if (storePhoto != null && productPhoto != null) {
        String storeFileName = storePhoto.path.split('/').last;
        String productFileName = productPhoto.path.split('/').last;
        FormData formData = FormData.fromMap({
          'foto_toko': await MultipartFile.fromFile(storePhoto.path,
              filename: storeFileName,
              contentType: MediaType.parse('images/png')),
          'foto_produk': await MultipartFile.fromFile(productPhoto.path,
              filename: productFileName,
              contentType: MediaType.parse('images/png')),
          'fullname': fullName,
          'nama_toko': storeName,
          'alamat_toko': storeAddress,
          'kategori_id_produk': "1",
          'kategori_nama_produk': productCategory,
          'nama_produk': productName,
          'stok_produk': productStock,
          'harga_produk': productPrice,
        });

        Response response = await Dio()
            .post('https://dev.tolongbeliin.com/api/merchant/makanan/add',
                data: formData,
                options: Options(headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                }));
        print(response.data);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<dynamic>> getProduct(String fullname) async {
    Map<String, dynamic> body = {};
    body['fullname'] = fullname;
    Response response = await Dio().get(
      'https://dev.tolongbeliin.com/api/merchant/makanan/list',
      data: body,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    List<dynamic> product = response.data['data'];
    return product;
  }

  void editProductDio(StoreForm store, ProductForm product) async {
    try {
      //STORE
      String? storeName = store.name;
      String? storeAddress = store.address;
      String? fullName = store.fullname;
      File? storePhoto = store.photo;

      String? productName = product.name;
      String? productPrice = product.price;
      String? productCategory = product.category;
      String? productCategoryId = product.categoryId;
      String? productStock = product.stock;
      int? productId = product.idProduct;
      File? productPhoto = product.photo;


      if (storePhoto != null && productPhoto != null) {
        String storeFileName = storePhoto.path.split('/').last;
        String productFileName = productPhoto.path.split('/').last;
        FormData formData = FormData.fromMap({
          'foto_toko': await MultipartFile.fromFile(storePhoto.path,
              filename: storeFileName,
              contentType: MediaType.parse('images/png')),
          'foto_produk': await MultipartFile.fromFile(productPhoto.path,
              filename: productFileName,
              contentType: MediaType.parse('images/png')),
          'fullname': fullName,
          'id_toko' : '2',
          'nama_toko': storeName,
          'alamat_toko': storeAddress,
          'kategori_id_produk': productCategoryId,
          'kategori_nama_produk': productCategory,
          'nama_produk': productName,
          'stok_produk': productStock,
          'harga_produk': productPrice,
          'produk_id' : productId
        });
        Dio dio = new Dio();
        Response response = await dio
            .post('https://dev.tolongbeliin.com/api/merchant/makanan/edit',
            data: formData,
            options: Options(headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            }, sendTimeout: Duration(seconds: 5)));
        print(response.data);
      }
    } catch (error) {
      print(error);
    }
  }
  Future<void> editProduct(StoreForm store, ProductForm product) async {
    String storeName = store.name.toString();
    String storeAddress = store.address.toString();
    String fullName = store.fullname.toString();
    File? storePhoto = store.photo;
    String idStore = store.storeId.toString();

    String productName = product.name.toString();
    String productPrice = product.price.toString();
    String productCategory = product.category.toString();
    String productCategoryId = product.categoryId.toString();
    String productStock = product.stock.toString();
    String productId = product.idProduct.toString();
    File? productPhoto = product.photo;

    if (storePhoto != null && productPhoto != null) {
      print('masuk');
      String storeFileName = storePhoto.path.split('/').last;
      String productFileName = productPhoto.path.split('/').last;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://dev.tolongbeliin.com/api/merchant/makanan/edit'),
      );
      request.fields['fullname'] = fullName;
      request.fields['id_toko'] = idStore;
      request.fields['nama_toko'] = storeName;
      request.fields['alamat_toko'] = storeAddress;
      request.fields['kategori_id_produk'] = productCategoryId;
      request.fields['kategori_nama_produk'] = productCategory;
      request.fields['nama_produk'] = productName;
      request.fields['stok_produk'] = productStock;
      request.fields['harga_produk'] = productPrice;
      request.fields['produk_id'] = productId;


      request.files.add(
        await http.MultipartFile.fromPath(
        'foto_toko',
        storePhoto.path,
        contentType: MediaType('images', 'png'),
      ),);
      request.files.add(
        await http.MultipartFile.fromPath(
          'foto_produk',
          productPhoto.path,
          contentType: MediaType('images', 'png'),
        ),);
      var response = await request.send();
      print(response.statusCode);
    }
    else {
      print("errror");
    }


  }

  Future<http.Response> deleteMakanan(String fullname, String produk_id) {
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


}
