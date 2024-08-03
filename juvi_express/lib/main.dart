import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/pages/admin/orders/list/admin_orders_list_page.dart';
import 'package:juvi_express/src/pages/client/products/list/client_products_list_page.dart';
import 'package:juvi_express/src/pages/delivery/orders/list/delivery_orders_page.dart';
import 'package:juvi_express/src/pages/home/home_page.dart';
import 'package:juvi_express/src/pages/login/login_page.dart';
import 'package:juvi_express/src/pages/register/register_page.dart';
import 'package:juvi_express/src/pages/roles/roles_page.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Juvi-Express",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber, // Color principal de la aplicación
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber), // Color del borde cuando está enfocado
          ),
        ),
      ),
      initialRoute: userSession.id != null ? userSession.roles!.length > 1 ? '/roles': '/client/products/list': '',
      getPages: [
        GetPage(name: '/', page: ()=> LoginPage()),
        GetPage(name: '/register', page: ()=> RegisterPage()),
        GetPage(name: '/home', page: ()=> HomePage()),
        GetPage(name: '/roles', page: ()=> RolesPage()),
        GetPage(name: '/admin/orders/list', page: ()=> AdminOrdersListPage()),
        GetPage(name: '/delivery/orders/list', page: ()=> DeliveryOrdersPage()),
        GetPage(name: '/client/products/list', page: ()=> ClientProductsListPage()),
        
      ],
      navigatorKey: Get.key,
    );
  }
}

/*
theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
          onBackground: Colors.grey,
          brightness: Brightness.light,
          onPrimary: Colors.amber,
          surface: Colors.white,
          onSurface: Colors.grey,
          error: Colors.red,
          onError: Colors.red,
          onSecondary: Colors.amber,
          //background: Colors.grey,
        )
        */