import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';

class DeliveryOrdersPage extends StatelessWidget {

  DeliveryOrdersListController con = Get.put(DeliveryOrdersListController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Delivery Orders List'),
        
      ),
    );
  }
}