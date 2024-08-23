import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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


class ClientPaymentsCreateController extends GetxController {

  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});
  var radioValue = 0.obs;

  ImagePicker picker = ImagePicker();
  File? imageFile;

  var paymentMethod = ''.obs;
  String receipt = '';
  String cashAmount = '';
  var receiptPath = ''.obs; 

  void selectPaymentMethod(String? method) {
    paymentMethod.value = method ?? '';
  }

  void processPayment(BuildContext context) {
    if (paymentMethod.value == 'transferencia') {
      // Lógica para manejar la transferencia bancaria
      print('Método de pago: Transferencia Bancaria');
      print('Comprobante: $receipt');
      print('Ruta del comprobante: ${receiptPath.value}');
      print('Que es esto??: ${context}');
      createPayment(context);
    } else if (paymentMethod.value == 'efectivo') {
      // Lógica para manejar el pago en efectivo
      print('Método de pago: Efectivo');
      print('Monto disponible: $cashAmount');
    }
  }




  void createPayment(BuildContext context) async {
    Address a = Address.fromJson(GetStorage().read('address') ?? {});
    List<Product> products = Product.fromJsonList(GetStorage().read('shopping_bag'));

    Order order = Order(
      idClient: user.id,
      idAddress: a.id,
      products: products,
    );

    print('ID DEL CLIENTE? ${order.idClient}');
    print('ID DEL DIRECCION? ${order.idAddress}');
    print('PRODUCTOS? ${order.products}');

    if (imageFile != null) {
      print("Llego aqui? ${imageFile}");
      Stream stream = await ordersProvider.createWithImage(order, imageFile!);
      print('steam? ${stream}');
      stream.listen((res) {
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        print('Que respuesta es? ${responseApi.data}');

        if (responseApi.success == true) {
          GetStorage().write('order', responseApi.data);
          print('Y ESTO? ${responseApi.data}');
          //Get.toNamed('/client/payments/create');
        } else {
          Get.snackbar("Registro Fallido", responseApi.message ?? '');
        }
      });
    } else {
      // Manejar el caso en que no se ha seleccionado una imagen
      ResponseApi responseApi = await ordersProvider.create(order);
      if (responseApi.success == true) {
        GetStorage().write('order', responseApi.data);
        //Get.toNamed('/client/payments/create');
      } else {
        Get.snackbar("Registro Fallido", responseApi.message ?? '');
      }
    }
  }
  

void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      }, 
      child: Text('Galeria')
      );
      Widget cameraButton = ElevatedButton(
        onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      }, 
        child: Text('Camara')
        );

        AlertDialog alertDialog = AlertDialog(
          title: Text('Selecciona una opcion'),
          actions: [
            galleryButton,
            cameraButton
          ],
        );

        showDialog(context: context, builder: (BuildContext context){
          return alertDialog;
        });
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      imageFile = File(image.path);
      update();
    }

  }



}
