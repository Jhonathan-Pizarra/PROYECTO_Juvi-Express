import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/order.dart';
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
      Get.snackbar('Peticion denegada', 'Debes asignar el repartidor');
    }
  }

  void getDeliveryMen() async {
    var result = await usersProvider.findDeliveryMen();
    users.clear();
    users.addAll(result);
  }
  
  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }


}