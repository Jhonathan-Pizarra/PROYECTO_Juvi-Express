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
import 'package:juvi_express/src/pages/client/home/client_home_page.dart';
import 'package:juvi_express/src/providers/address_provider.dart';
import 'package:juvi_express/src/providers/orders_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

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
      createPayment(context);
    }
  }

  void createPayment(BuildContext context) async {
    print('User ID: ${user.id}');

    Address a = Address.fromJson(GetStorage().read('address') ?? {});
    //List<Product> products = Product.fromJsonList(GetStorage().read('shopping_bag'));

    List<dynamic> productJson = GetStorage().read('shopping_bag') ?? [];
    List<Product> products;

    if (productJson is List<Product>) {
      products = productJson;
    } else {
      products = productJson.map((item) => Product.fromJson(item)).toList();
    }

    Order order = Order(idClient: user.id, idAddress: a.id, products: products);

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(max: 100, msg: "Registrando...");

    print('ORDER ${order.toJson()}');
    print('ID DEL CLIENTE? ${order.idClient}');
    print('ID DEL DIRECCION? ${order.idAddress}');
    print('PRODUCTOS? ${order.products?.map((p) => p.toJson()).toList()}');

    print('Imgen? ${imageFile}');

    if (imageFile != null) {
      try {
        ResponseApi responseApi = await ordersProvider.createWithImage(order, imageFile!);

        progressDialog.close();

        print('Que respuesta es? ${responseApi}');
        print('Que data es? ${responseApi.data}');

        if (responseApi.success == true) {
          GetStorage().write('order', responseApi.data);
          Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
          //update();
          //Get.toNamed('/client/home');
          Get.offAll(ClientHomePage());
          //Get.offNamed('/client/home');
          //Get.toNamed('/client/products/list');
        } else {
         // Get.snackbar("Registro Fallido", responseApi.message ?? '');
          Get.snackbar(
            'Registro Fallido', responseApi.message ?? '',
            backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
            colorText: Colors.white,  // Color del texto
            snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
            borderRadius: 8,  // Bordes redondeados
            margin: EdgeInsets.all(10),  // Márgenes alrededor
            animationDuration: Duration(milliseconds: 300),  // Duración de la animación
            duration: Duration(seconds: 3),  // Duración visible
          );
          
        }
      } catch (e) {
        progressDialog.close();
        print('Error al crear el pedido con imagen: $e');
        //Get.snackbar("Error", "No se pudo crear el pedido con imagen");
      }
    } else {
      try {
        ResponseApi responseApi = await ordersProvider.create(order);
        if (responseApi.success == true) {
          GetStorage().write('order', responseApi.data);
          Get.toNamed('/client/home');
          Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
        } else {
          //Get.snackbar("Registro Fallido", responseApi.message ?? '');
          Get.snackbar(
            'Registro Fallido', responseApi.message ?? '',
            backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
            colorText: Colors.white,  // Color del texto
            snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
            borderRadius: 8,  // Bordes redondeados
            margin: EdgeInsets.all(10),  // Márgenes alrededor
            animationDuration: Duration(milliseconds: 300),  // Duración de la animación
            duration: Duration(seconds: 3),  // Duración visible
          );
          
        }
      } catch (e) {
        print('Error al crear la orden sin imagen: $e');
        //Get.snackbar("Error", "No se pudo crear el pedido");
      }
    }
  }

  /*
  //  v1
  void createPayment(BuildContext context) async {
    print('User ID: ${user.id}');
 
    
    Address a = Address.fromJson(GetStorage().read('address') ?? {});
    //List<Product> products = Product.fromJsonList(GetStorage().read('shopping_bag'));

    List<dynamic> productJson = GetStorage().read('shopping_bag') ?? [];
    List<Product> products;

    if (productJson is List<Product>) {
      products = productJson;
    } else {
      products = productJson.map((item) => Product.fromJson(item)).toList();
    }

    Order order = Order(
      idClient: user.id,
      idAddress: a.id,
      products: products
    );

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(max: 100, msg: "Registradno...");

    print('ORDER ${order.toJson()}');
    print('ID DEL CLIENTE? ${order.idClient}');
    print('ID DEL DIRECCION? ${order.idAddress}');
    print('PRODUCTOS? ${order.products?.map((p) => p.toJson()).toList()}');
    

    if (imageFile != null) {
      Stream stream = await ordersProvider.createWithImage(order, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        print('Que respuesta es? ${responseApi}');
        print('Que data es? ${responseApi.data}');

        if (responseApi.success == true) {
          GetStorage().write('order', responseApi.data);
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
  */

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text('Galeria'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text('Camara'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
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
