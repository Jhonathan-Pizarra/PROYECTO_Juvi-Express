import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/providers/users_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController namelController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
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
      
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: "Registradno...");

      User user = User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        password: password
      );

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res){
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if(responseApi.success == true){

          GetStorage().write('user', responseApi.data);
          goToHomePage();

        }else{
          Get.snackbar("Registro Fallido", responseApi.message ?? '');
        }

      });

      //Response response = await usersProvider.create(user);

      //print("Respuesta: ${response.body}");

      //Get.snackbar('Formulario válido', "Estas listo para eviar la peticion http");
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

    if(imageFile == null){
      Get.snackbar("Formulario no válido", "Debe seleccionar una imagen de perfil");
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      imageFile = File(image.path);
      update();
    }

  }

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      }, 
      child: Text('Galeria')
      );
      Widget cameraButton = ElevatedButton(
        onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      }, 
        child: Text('Camara')
        );

        AlertDialog alertDialog = AlertDialog(
          title: Text('Selecciona una opcion'),
          actions: [
            galleryButton,
            cameraButton
          ],
        );

        showDialog(context: context, builder: (BuildContext context){
          return alertDialog;
        });
  }

  void goToHomePage(){
    Get.offNamedUntil('/home',(route) => false);
  }
  
}
