import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/enviroment/enviroment.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';

class CategoriesProvider extends GetConnect {

  
  String url = Enviroment.API_URL + 'api/categories';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Category>> getAll() async {
    Response response = await get(
      '$url/getAll',
      headers: {
        'Content-Type': "application/json",
        'Authorization': userSession.sessionToken ?? ''
      }
    );

    //ResponseApi responseApi = ResponseApi.fromJson(response.body);

    if (response.statusCode == 401) {

      //Get.snackbar('Peticion denegada', 'Inicie sesión para continuar');
      Get.snackbar(
        'Peticion denegada', 'Inicie sesión para continuar',
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

    List<Category> categories = [];
    if (response.body != null && response.body is List) {
      categories = Category.fromJsonList(response.body);
    } else {
      //Get.snackbar('Error', 'No se pudo obtener los productos.');
      Get.snackbar(
        'Peticion denegada', 'Parece que el stock está vacío, vuelve más tarde',
        backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
    }
 
    return categories;

  }


  Future<ResponseApi> create (Category category) async {
    Response response = await post(
      '$url/create',
      category.toJson(),
      headers: {
        'Content-Type': "application/json",
        'Authorization': userSession.sessionToken ?? ''
      }
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  
}