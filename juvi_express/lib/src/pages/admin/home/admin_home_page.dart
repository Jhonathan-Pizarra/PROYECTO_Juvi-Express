import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/admin/categories/create/admin_categories_create_page.dart';
import 'package:juvi_express/src/pages/admin/home/admin_home_controller.dart';
import 'package:juvi_express/src/pages/admin/orders/list/admin_orders_list_page.dart';
import 'package:juvi_express/src/pages/admin/products/create/admin_products_create_page.dart';
import 'package:juvi_express/src/pages/client/home/client_home_controller.dart';
import 'package:juvi_express/src/pages/client/products/list/client_prducts_list_controller.dart';
import 'package:juvi_express/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:juvi_express/src/pages/delivery/orders/list/delivery_orders_page.dart';
import 'package:juvi_express/src/pages/register/register_page.dart';
import 'package:juvi_express/src/utils/custom_animated_bottom_bar.dart';

class AdminHomePage extends StatelessWidget {

  AdminHomeController con = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonBar(),
      body: Obx(() => IndexedStack( 
        index: con.indexTab.value,
        children: [
          AdminOrdersListPage(),
          AdminCategoriesCreatePage(),
          AdminProductsCreatePage(),
          //DeliveryOrdersPage(),
          ClientProfileInfoPage()
          //egisterPage()
        ],
      )
    ));
  }

  Widget _bottonBar(){
    return Obx(()=> CustomAnimatedBottomBar(
      containerHeight: 70, 
      backgroundColor: Colors.amber,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.apps), 
          title: Text('Pedidos'),
          activeColor: Colors.white,
          inactiveColor: Colors.black
          ),
        BottomNavyBarItem(
          icon: Icon(Icons.category), 
          title: Text('Categoria'),
          activeColor: Colors.white,
          inactiveColor: Colors.black
          ),
        BottomNavyBarItem(
          icon: Icon(Icons.restaurant), 
          title: Text('Producto'),
          activeColor: Colors.white,
          inactiveColor: Colors.black
          ),
        BottomNavyBarItem(
          icon: Icon(Icons.person), 
          title: Text('Perfil'),
          activeColor: Colors.white,
          inactiveColor: Colors.black
          )
      ],
    ));
  }
}