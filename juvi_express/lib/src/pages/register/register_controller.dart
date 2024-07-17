import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController namelController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() {
    String email = emailController.text.trim();
    String name = namelController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    Get.snackbar('Email', email);
    Get.snackbar('Password', password);

    if (isValidForm(email, name, lastName, phone, password, confirmPassword)) {
      Get.snackbar(
          'Formulario válido', "Estas listo para eviar la peticion http");
    }
  }

  bool isValidForm(String email, String name, String lastName, String phone, String password, String confirmPassword) {

    if (email.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar un email");
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Formulario no válido", "Debes ingresar un email válido");
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar un nombre");
      return false;
    }

    if (lastName.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar un apellido");
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar un telefono");
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar tu clave");
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar("Formulario no válido", "Debes ingresar tu clave");
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar("Formulario no válido", "Contraseñas no coinciden");
      return false;
    }

    return true;
  }

}
