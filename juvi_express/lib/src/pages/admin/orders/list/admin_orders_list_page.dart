import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/admin/orders/list/admin_orders_list_controller.dart';

class AdminOrdersListPage extends StatelessWidget {

  AdminOrdersListController con = Get.put(AdminOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Admin Orders List'),
      ),
    );
  }
}