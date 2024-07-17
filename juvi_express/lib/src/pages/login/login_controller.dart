import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void login(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    Get.snackbar('Email', email);
    Get.snackbar('Password', password);

    if (isValidForm(email, password)) {
      Get.snackbar('Formulario válido', "Estas listo para eviar la peticion http");
    }

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