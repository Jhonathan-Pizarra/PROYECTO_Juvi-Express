import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:juvi_express/src/providers/users_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientProfileUpdateController extends GetxController {

  User user = User.fromJson(GetStorage().read('user'));
  
  //TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();
  //TextEditingController confirmPasswordController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  ClientProfileInfoController clientProfileInfoController = Get.find();

  ClientProfileUpdateController(){
    nameController.text = user.name ?? '';
    lastNameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';

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

  bool isValidForm(
    String name, 
    String lastName, 
    String phone) {

      /*
      if (email.isEmpty) {
        Get.snackbar("Formulario no válido", "Debes ingresar un email");
        return false;
      }

      if (!GetUtils.isEmail(email)) {
        Get.snackbar("Formulario no válido", "Debes ingresar un email válido");
        return false;
      }
      */

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

      /*

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
      */

      return true;
    }

  void updateInfo(BuildContext context) async {
  String name = nameController.text;
  String lastName = lastNameController.text;
  String phone = phoneController.text;
  
  //Get.snackbar('Email', email);
  //Get.snackbar('Password', password);

  if (isValidForm(name, lastName, phone)) {
    
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(max: 100, msg: "Actualizando...");

    User myUser = User(
      //email: user.email,
      id: user.id,
      name: name,
      lastname: lastName,
      phone: phone,
      sessionToken: user.sessionToken
    );


    if (imageFile == null) {
      ResponseApi responseApi  = await usersProvider.update(myUser);
      print("Response API Update ${responseApi.data}");
      Get.snackbar('Proceso terminado',responseApi.message ?? '');
      progressDialog.close();
      if (responseApi.success == true) {
        //user.name = name;
        //user.lastname = lastName;
        //user.phone = phone;

        GetStorage().write('user', responseApi.data);
        //clientProfileInfoController.user = User.fromJson(responseApi.data); 
        clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});  
 
      }
    }else{

      Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
      stream.listen((res){

        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado',responseApi.message ?? '');
        print("Response API Update ${responseApi.data}");

        if(responseApi.success == true){

          //user.name = name;
          //user.lastname = lastName;
          //user.phone = phone;
          //user.image = responseApi.data['image'];
          GetStorage().write('user', responseApi.data);
          clientProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});  
          //clientProfileInfoController.user = User.fromJson(responseApi.data);

        }else{
          Get.snackbar("Registro Fallido", responseApi.message ?? '');
        }

      });

    }
    
    

    /*
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
    */

    //Response response = await usersProvider.create(user);

    //print("Respuesta: ${response.body}");

    //Get.snackbar('Formulario válido', "Estas listo para eviar la peticion http");
  }
}


}