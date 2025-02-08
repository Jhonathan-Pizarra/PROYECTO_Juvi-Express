import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/enviroment/enviroment.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider extends GetConnect {

  String url = Enviroment.API_URL + 'api/products';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  
    Future<List<Product>> findByCategory(String idCategory) async {
    try {
      Response response = await get(
        '$url/findByCategory/$idCategory',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
      );

      if (response.statusCode == 401) {
        //Get.snackbar('Petición denegada', 'Tu usuario no tiene permitido leer esta información');
         Get.snackbar(
          'Peticion denegada', 'Tu usuario no tiene permitido leer esta información',
          backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
          colorText: Colors.white,  // Color del texto
          snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
          borderRadius: 8,  // Bordes redondeados
          margin: EdgeInsets.all(10),  // Márgenes alrededor
          animationDuration: Duration(milliseconds: 300),  // Duración de la animación
          duration: Duration(seconds: 3),  // Duración visible
        );
        return [];
      }

      if (response.body != null && response.body is List) {
        return Product.fromJsonList(response.body);
      } else {
        return [];
      }
    } catch (e) {
      //Get.snackbar('Error', 'Ocurrió un error al cargar los productos.');
      Get.snackbar(
          'Error', 'Ocurrió un error al cargar los productos.',
          backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
          colorText: Colors.white,  // Color del texto
          snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
          borderRadius: 8,  // Bordes redondeados
          margin: EdgeInsets.all(10),  // Márgenes alrededor
          animationDuration: Duration(milliseconds: 300),  // Duración de la animación
          duration: Duration(seconds: 3),  // Duración visible
        );
      return [];
    }
  }

  Future<List<Product>> findByNameAndCategory(String idCategory, String name) async {
    try {
      Response response = await get(
        '$url/findByNameAndCategory/$idCategory/$name',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
      );

      if (response.statusCode == 401) {
        //Get.snackbar('Petición denegada', 'Tu usuario no tiene permitido leer esta información');
        Get.snackbar(
          'Petición denegada', 'Tu usuario no tiene permitido leer esta información',
          backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
          colorText: Colors.white,  // Color del texto
          snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
          borderRadius: 8,  // Bordes redondeados
          margin: EdgeInsets.all(10),  // Márgenes alrededor
          animationDuration: Duration(milliseconds: 300),  // Duración de la animación
          duration: Duration(seconds: 3),  // Duración visible
        );
        return [];
      }

      if (response.body != null && response.body is List) {
        return Product.fromJsonList(response.body);
      } else {
        return [];
      }
    } catch (e) {
      //Get.snackbar('Error', 'Ocurrió un error al cargar los productos.');
      Get.snackbar(
          'Error', 'Ocurrió un error al cargar los productos.',
          backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
          colorText: Colors.white,  // Color del texto
          snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
          borderRadius: 8,  // Bordes redondeados
          margin: EdgeInsets.all(10),  // Márgenes alrededor
          animationDuration: Duration(milliseconds: 300),  // Duración de la animación
          duration: Duration(seconds: 3),  // Duración visible
        );
      return [];
    }
  }

  Future<Stream> create(Product product, List<File> images) async {
    Uri uri = Uri.http(Enviroment.API_URL_OLD, '/api/products/create');
    
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = userSession.sessionToken ?? '';

    for(int i = 0; i<images.length; i++){

      request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(images[i].openRead().cast()),
      await images[i].length(),
      filename: basename(images[i].path)
      ));

    }


    request.fields['product'] = json.encode(product);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }


}