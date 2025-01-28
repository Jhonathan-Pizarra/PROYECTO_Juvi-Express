import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/admin/categories/create/admin_categories_create_page.dart';
import 'package:juvi_express/src/pages/admin/home/admin_home_controller.dart';
import 'package:juvi_express/src/pages/admin/orders/list/admin_orders_list_page.dart';
import 'package:juvi_express/src/pages/admin/products/create/admin_products_create_page.dart';
import 'package:juvi_express/src/pages/admin/users/admin_users_list_page.dart';
import 'package:juvi_express/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:juvi_express/src/utils/custom_animated_bottom_bar.dart';

class AdminHomePage extends StatelessWidget {
  final AdminHomeController con = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: Obx(
        () => IndexedStack(
          index: con.indexTab.value,
          children: [
            AdminOrdersListPage(),
            AdminCategoriesCreatePage(),
            AdminProductsCreatePage(),
            ClientProfileInfoPage(),
            AdminUsersListPage(),//Vamos a crear una nueva interfaz para usuarios
          ],
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return Obx(
      () => CustomAnimatedBottomBar(
        containerHeight: 70,
        itemCornerRadius: 24,
        selectedIndex: con.indexTab.value,
        onItemSelected: (index) => con.changeTab(index),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: 'Pedidos',
            activeColor: Colors.white,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.category),
            title: 'Categorías',
            activeColor: Colors.white,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.restaurant),
            title: 'Productos',
            activeColor: Colors.white,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: 'Perfil',
            activeColor: Colors.white,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: 'Usuario',
            activeColor: Colors.white,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class CustomAnimatedBottomBar extends StatelessWidget {
  CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.iconSize = 24,
    this.containerHeight = 60,
    this.animationDuration = const Duration(milliseconds: 300),
    this.itemCornerRadius = 30,
    this.items = const [],
    required this.onItemSelected,
  })  : assert(items.length >= 2 && items.length <= 6),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final double containerHeight;
  final double itemCornerRadius;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber, // Fondo blanco para que se vea más limpio
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 3,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: containerHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: AnimatedContainer(
                  duration: animationDuration,
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? item.activeColor.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(itemCornerRadius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          size: selectedIndex == index
                              ? iconSize + 6
                              : iconSize,
                          color: selectedIndex == index
                              ? item.activeColor
                              : item.inactiveColor,
                        ),
                        child: item.icon,
                      ),
                      if (selectedIndex == index)
                        SizedBox(height: 4),
                      if (selectedIndex == index)
                        Text(
                          item.title,
                          style: TextStyle(
                            color: item.activeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10, // Tamaño más pequeño solo en AdminHomePage
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.amber,
    this.inactiveColor,
  });

  final Widget icon;
  final String title;
  final Color activeColor;
  final Color? inactiveColor;
}
