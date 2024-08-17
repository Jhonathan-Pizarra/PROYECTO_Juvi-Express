import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/admin/categories/create/admin_categories_create_page.dart';
import 'package:juvi_express/src/pages/admin/home/admin_home_controller.dart';
import 'package:juvi_express/src/pages/admin/orders/list/admin_orders_list_page.dart';
import 'package:juvi_express/src/pages/admin/products/create/admin_products_create_page.dart';
import 'package:juvi_express/src/pages/client/home/client_home_controller.dart';
import 'package:juvi_express/src/pages/client/products/list/client_prducts_list_controller.dart';
import 'package:juvi_express/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:juvi_express/src/pages/delivery/home/delivery_home_controller.dart';
import 'package:juvi_express/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:juvi_express/src/pages/register/register_page.dart';
import 'package:juvi_express/src/utils/custom_animated_bottom_bar.dart';

class DeliveryHomePage extends StatelessWidget {

  DeliveryHomeController con = Get.put(DeliveryHomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: Obx(() => IndexedStack(
        index: con.indexTab.value,
        children: [
          DeliveryOrdersListPage(),
          ClientProfileInfoPage()
        ],
      ))
    );
  }

  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.amber,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Pedidos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
      ],
    ));
  }



}