import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/pages/admin/home/admin_home_page.dart';
import 'package:juvi_express/src/pages/client/address/create/client_address_create_page.dart';
import 'package:juvi_express/src/pages/client/address/list/client_address_list_paige.dart';
import 'package:juvi_express/src/pages/client/home/client_home_page.dart';
import 'package:juvi_express/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:juvi_express/src/pages/client/products/list/client_products_list_page.dart';
import 'package:juvi_express/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:juvi_express/src/pages/client/profile/update/client_profile_update_page.dart';
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
      primaryColor: Colors.amber,
      colorScheme: const ColorScheme(
        primary: Colors.amber,
        secondary: Colors.amberAccent,
        brightness: Brightness.light,
        onPrimary: Colors.grey,
        surface: Colors.white,
        onSurface: Colors.grey,
        error: Colors.grey,
        onError: Colors.grey,
        onSecondary: Colors.grey,
      ),
    ),
      initialRoute: userSession.id != null ? userSession.roles!.length > 1 ? '/roles': '/client/home': '',
      getPages: [
        GetPage(name: '/', page: ()=> LoginPage()),
        GetPage(name: '/register', page: ()=> RegisterPage()),
        GetPage(name: '/home', page: ()=> HomePage()),
        GetPage(name: '/roles', page: ()=> RolesPage()),
        GetPage(name: '/admin/home', page: ()=> AdminHomePage()),
        GetPage(name: '/delivery/orders/list', page: ()=> DeliveryOrdersPage()),
        GetPage(name: '/client/products/list', page: ()=> ClientProductsListPage()),
        //Usr Profile
        GetPage(name: '/client/profile/info', page: ()=> ClientProfileInfoPage()),
        GetPage(name: '/client/profile/update', page: ()=> ClientProfileUpdatePage()),
        //User Home
        GetPage(name: '/client/home', page: ()=> ClientHomePage()),
        
        GetPage(name: '/client/orders/create', page: ()=> ClientOrdersCreatePage()),
        //Address
        GetPage(name: '/client/address/create', page: ()=> ClientAddressCreatePage()),
        GetPage(name: '/client/address/list', page: ()=> ClientAddressListPaige()),


      ],
      navigatorKey: Get.key,
    );
  }
}


//Version 1
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

//Version 2
/*
 theme: ThemeData(
      primaryColor: Colors.amber,
      colorScheme: const ColorScheme(
        primary: Colors.amber,
        secondary: Colors.amberAccent,
        brightness: Brightness.light,
        onPrimary: Colors.grey,
        surface: Colors.grey,
        onSurface: Colors.grey,
        error: Colors.grey,
        onError: Colors.grey,
        onSecondary: Colors.grey,
      ),
    ),
*/ 

/*
theme: ThemeData(
        primaryColor: Colors.amber, // Color principal de la aplicación
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber), // Color del borde cuando está enfocado
          ),
        ),
      ),
*/