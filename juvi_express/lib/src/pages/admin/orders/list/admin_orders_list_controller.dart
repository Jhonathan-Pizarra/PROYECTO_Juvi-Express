import 'package:get/get.dart';
import 'package:juvi_express/src/models/order.dart';
import 'package:juvi_express/src/providers/orders_provider.dart';

class AdminOrdersListController extends GetxController {

  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;
    
  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByStatus(status);
  }

  void goToOrderDetail (Order order) {
    Get.toNamed('/admin/orders/detail', arguments: {
      'order': order.toJson()
    });
  }

}