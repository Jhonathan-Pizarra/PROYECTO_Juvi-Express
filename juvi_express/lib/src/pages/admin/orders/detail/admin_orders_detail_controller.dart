import 'package:get/get.dart';
import 'package:juvi_express/src/models/order.dart';

class AdminOrdersDetailController extends GetxController{

  Order order = Order.fromJson(Get.arguments['order']);
  var total = 0.0.obs;

  AdminOrdersDetailController() {
    print('Order: ${order.toJson()}');
    //getDeliveryMen();
    //getTotal();
  } 
  
  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }


}