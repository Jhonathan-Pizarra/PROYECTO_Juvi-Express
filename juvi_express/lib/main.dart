import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/login/login_page.dart';

void main() {
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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> LoginPage())
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