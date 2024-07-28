//import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/providers/users_provider.dart';

class LoginController extends GetxController{
  
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

    //Get.snackbar('Email', email);
    //Get.snackbar('Password', password);

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);
      print('Respuesta API: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        
        GetStorage().write('user', responseApi.data);
        goToHomePage();
        //Get.snackbar('Sesión Iniciada', "Bienvenid@ a JuviExpress");        
      }else{
        Get.snackbar('Error de sesión', responseApi.message ?? '');        
      }
    
    }

  }

  /*
  void goToHomePage(){
    Get.toNamed('/home');
  }
  */

  void goToHomePage(){
    Get.offNamedUntil('/home',(route) => false);
  }
  

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