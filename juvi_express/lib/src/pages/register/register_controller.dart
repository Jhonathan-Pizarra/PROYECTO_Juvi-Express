import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/providers/users_provider.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController namelController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void register() async {
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
      
      User user = User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        password: password
      );

      Response response = await usersProvider.create(user);

      print("Respuesta: ${response.body}");

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
