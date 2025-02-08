import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/order.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/providers/orders_provider.dart';
import 'package:juvi_express/src/providers/users_provider.dart';

class AdminOrdersDetailController extends GetxController{

  Order order = Order.fromJson(Get.arguments['order']);
  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  AdminOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getDeliveryMen();
    getTotal();
    
  } 

  void updateOrder() async {
    if (idDelivery.value != '') { // SI SELECCIONO EL DELIVERY
      order.idDelivery = idDelivery.value;
      ResponseApi responseApi = await ordersProvider.updateToDispatched(order);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if (responseApi.success == true) {
        Get.offNamedUntil('/admin/home', (route) => false);
      }
    }
    else {
      //Get.snackbar('Peticion denegada', 'Debes asignar el repartidor');
      Get.snackbar(
        'Operación denegada', 'Debes asignar el repartidor',
        backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
    }
  }

  void getDeliveryMen() async {
    var result = await usersProvider.findDeliveryMen();
    users.clear();
    users.addAll(result);
  }
  
  /*
  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
   
    });
    
  }*/

  void getTotal() {
      total.value = 0.0;

      order.products?.forEach((product) {
        //print('PRODUCT QUATINTY? ${product.quantity}');
        //print('PRODUCT PRICE? ${product.price}');
        double quantity = (product.quantity ?? 0).toDouble(); // Convertir a double
        double price = product.price ?? 0.0; // Si es null, asigna 0.0
        total.value += quantity * price;
      });
  }


}

   /*if (product.quantity == null || product.price == null) {
      Fluttertoast.showToast(msg: 'Producto con cantidad o precio nulo', toastLength: Toast.LENGTH_SHORT);
      } else {
        total.value = total.value + (product.quantity! * product.price!);
      }*/