import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juvi_express/src/models/address.dart';
import 'package:juvi_express/src/models/order.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/providers/address_provider.dart';
import 'package:juvi_express/src/providers/orders_provider.dart';

class ClientAddressListController extends GetxController {

  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});
  var radioValue = 0.obs;

  ImagePicker picker = ImagePicker();
  File? imageFile;

  ClientAddressListController() {
    print('LA DIRECCION DE SESION ${GetStorage().read('address')}');
  }

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    print('Address ${address}');
    Address a = Address.fromJson(GetStorage().read('address') ?? {}) ; // DIRECCION SELECCIONADA POR EL USUARIO
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) { // LA DIRECCION DE SESION COINCIDE CON UN DATOS DE LA LISTA DE DIRECCIONES
      radioValue.value = index;
    }

    return address;
  }




/*
  void goToPayments(BuildContext context) async {
  Address a = Address.fromJson(GetStorage().read('address') ?? {});
  List<Product> products = Product.fromJsonList(GetStorage().read('shopping_bag'));

  Order order = Order(
    idClient: user.id,
    idAddress: a.id,
    products: products,
  );

  if (imageFile != null) {
    Stream stream = await ordersProvider.createWithImage(order, imageFile!);
    stream.listen((res) {
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

      if (responseApi.success == true) {
        GetStorage().write('order', responseApi.data);
        Get.toNamed('/client/payments/create');
      } else {
        Get.snackbar("Registro Fallido", responseApi.message ?? '');
      }
    });
  } else {
    // Manejar el caso en que no se ha seleccionado una imagen
    ResponseApi responseApi = await ordersProvider.create(order);
    if (responseApi.success == true) {
      GetStorage().write('order', responseApi.data);
      Get.toNamed('/client/payments/create');
    } else {
      Get.snackbar("Registro Fallido", responseApi.message ?? '');
    }
  }
}
*/


  /*
  void createOrder() async {
      Address a = Address.fromJson(GetStorage().read('address') ?? {});
      print("Llegó aqui?");
      List<Product> products = Product.fromJsonList(GetStorage().read('shopping_bag'));
      print("LLegó acá?? + ${products}");
      Order order = Order(
        idClient: user.id,
        idAddress: a.id,
        products: products
      );

      ResponseApi responseApi = await ordersProvider.create(order);
      //Get.toNamed('/client/payments/create');
      //Get.snackbar('Orden creada', responseApi.message ?? '');
      print("Llegó aqui x2?");
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        print("Llegó aqui x3?");
        Get.toNamed('/client/payments/create');
      }
  }*/

  
  void goToPayments() async {
      
    Get.toNamed('/client/payments/create');
      
  }
  
    
    
  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    print('VALOR SELECCIONADO ${value}');
    GetStorage().write('address', address[value].toJson());
    update();
  }

  void goToAddressCreate(){
    Get.toNamed('/client/address/create');
  }


}