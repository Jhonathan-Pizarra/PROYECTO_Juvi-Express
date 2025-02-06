//import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/providers/users_provider.dart';


class LoginController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  
  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void login() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  print('Email ${email}');
  print('Password ${password}');

  if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);
      print('Respuesta API: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data);

        User myUser = User.fromJson(GetStorage().read('user') ?? {});

        print('Roles length: ${myUser.roles!.length}');

        if (myUser.roles!.length > 1) {
          goToRolesPage();
        } else if (myUser.roles!.isNotEmpty) { 
          // Si tiene un solo rol, verificamos cuál es
          String roleId = myUser.roles![0].id ?? "";

          print("Rol obtenido: $roleId"); // Verificar en la consola

          if (roleId == "1") {
            goToAdminHomePage();
          } else if (roleId == "2") {
            goToDeliveryHomePage();
          } else {
            goToClientHomePage();
          }
        } else {
          Get.snackbar("Error", "No se encontraron roles para este usuario");
        }
      } else {
        Get.snackbar('Error de sesión', responseApi.message ?? '');        
      }
    }
  }

  void goToAdminHomePage() {
    Get.offNamedUntil('/admin/home', (route) => false);
  }

  void goToDeliveryHomePage() {
    Get.offNamedUntil('/delivery/home', (route) => false);
  }

  void goToClientHomePage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }

  void goToRolesPage(){
    Get.offNamedUntil('/roles', (route) => false);
  }


  /*
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    //Get.snackbar('Email', email);
    //Get.snackbar('Password', password);

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);
      print('Respuesta API: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        
        GetStorage().write('user', responseApi.data);

        User myUser = User.fromJson(GetStorage().read('user') ?? {});

        print('Roles length: ${myUser.roles!.length}');

        if (myUser.roles!.length > 1) {
          goToRolesPage();
        }
        else { // SOLO UN ROL
          goToClientHomePage();
        }


        //goToHomePage();
        //goToRolesPage();
        //Get.snackbar('Sesión Iniciada', "Bienvenid@ a JuviExpress");        
      }else{
        Get.snackbar('Error de sesión', responseApi.message ?? '');        
      }
    
    }

  }*/

  /*
  void goToHomePage(){
    Get.toNamed('/home');
  }
  */

  /*
  void goToClientHomePage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }

  void goToRolesPage(){
    Get.offNamedUntil('/roles',(route) => false);
  }*/
  
  bool isValidForm(String email, String password){

    if (email.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar un email");
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Formulario no válido", "Debes ingresar un email válido");
      return false;   
    }

    if (password.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar tu clave");
      return false;
    }

    return true;
  }


}