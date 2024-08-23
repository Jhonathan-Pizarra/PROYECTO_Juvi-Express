import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/enviroment/enviroment.dart';
import 'package:juvi_express/src/models/order.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';


class OrdersProvider extends GetConnect {

  String url = Enviroment.API_URL + 'api/orders';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Order order) async {
    Response response = await post(
      '$url/create',
      order.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': userSession.sessionToken ?? ''
      }
    );

    if (response.statusCode == 201) {
      print('Orden creada + ${ResponseApi.fromJson(response.body)}');
      return ResponseApi.fromJson(response.body);
    } else {
      throw Exception('Error al crear la orden');
    }
  }


  // Crear una orden con imagen
  Future<Stream> createWithImage(Order order, File image) async {
  try {
    Uri uri = Uri.http(Enviroment.API_URL_OLD, '/api/orders/createWithImage');
    //Uri uri = Uri.parse('$url/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';

    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path),
    ));

    request.fields['order'] = json.encode(order.toJson());
    final response = await request.send();

    return response.stream.transform(utf8.decoder);

    //final responseBody = await response.stream.transform(utf8.decoder).join();
    //final responseJson = json.decode(responseBody);
    
    //return ResponseApi.fromJson(responseJson);

  } catch (e) {
    print('Error al subir la imagen: $e');
    throw Exception('Error al crear la orden con imagen');
  }
}


  Future<List<Order>> findByStatus(String status) async {
    Response response = await get(
        '$url/findByStatus/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }


     List<Order> orders = [];
    if (response.body != null && response.body is List) {
      orders = Order.fromJsonList(response.body);
    } else {
      Get.snackbar('Error', 'No se pudo obtener los pedidos.');
    }
 
    return orders;

  }

  Future<List<Order>> findByDeliveryAndStatus(String idDelivery, String status) async {
    Response response = await get(
        '$url/findByDeliveryAndStatus/$idDelivery/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<List<Order>> findByClientAndStatus(String idClient, String status) async {
    Response response = await get(
        '$url/findByClientAndStatus/$idClient/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    
    List<Order> orders = [];
    if (response.body != null && response.body is List) {
      orders = Order.fromJsonList(response.body);
    } else {
      Get.snackbar('Error', 'No se pudo obtener los productos.');
    }
 

    return orders;
  }

  Future<ResponseApi> updateToDispatched(Order order) async {
    Response response = await put(
        '$url/updateToDispatched',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateToOnTheWay(Order order) async {
    Response response = await put(
        '$url/updateToOnTheWay',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateToDelivered(Order order) async {
    Response response = await put(
        '$url/updateToDelivered',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> updateLatLng(Order order) async {
    Response response = await put(
        '$url/updateLatLng',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }



}