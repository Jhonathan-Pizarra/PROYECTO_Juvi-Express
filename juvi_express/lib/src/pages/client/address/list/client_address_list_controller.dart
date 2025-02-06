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


  void goToPayments() async {
  // Verifica si se ha seleccionado una dirección
  if (radioValue.value < 0 || radioValue.value >= address.length) {
    // Muestra un mensaje de error si no hay dirección seleccionada
    Fluttertoast.showToast(
      msg: 'Por favor, elije una dirección antes de continuar.',
      toastLength: Toast.LENGTH_LONG,
    );
    return; // Sale de la función si no se ha seleccionado una dirección
  }

  // Guardar la dirección seleccionada en GetStorage
  Address selectedAddress = address[radioValue.value];
  GetStorage().write('address', selectedAddress.toJson());

  // Redirigir a la página de pagos
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