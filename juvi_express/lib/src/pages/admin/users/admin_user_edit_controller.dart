import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/models/rol.dart';
import 'package:juvi_express/src/providers/users_provider.dart';


class AdminUserEditController extends GetxController {
  final UsersProvider userProvider = UsersProvider();

  final formKey = GlobalKey<FormState>();

  RxString id = ''.obs;
  RxString lastname = ''.obs;
  RxString image = ''.obs;
  RxString password = ''.obs;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxList<Rol> roles = <Rol>[].obs; // Todos los roles disponibles
  RxList<Rol> selectedRoles = <Rol>[].obs; // Roles seleccionados por el usuario

  late User user;

  void loadUserData(User user) {
    this.user = user;
    id.value = user.id ?? '0';
    lastname.value = user.lastname ?? '';
    image.value = user.image ?? '';
    name.value = user.name ?? '';
    email.value = user.email ?? '';
    phone.value = user.phone ?? '';

    // Cargar roles del usuario
    roles.value = getAllRoles(); // Método para obtener todos los roles del sistema
    // Marcar los roles que ya tiene el usuario como seleccionados
    selectedRoles.value = roles.where((role) {
      return user.roles?.any((userRole) => userRole.id == role.id) ?? false;
    }).toList();
  }

  void toggleRoleSelection(Rol role, bool isSelected) {
    if (isSelected) {
      selectedRoles.add(role);
    } else {
      selectedRoles.remove(role);
    }
  }

   Future<void> updateUser() async {
    if (!formKey.currentState!.validate()) return;

    final updatedUser = User(
      id: id.value,
      email: email.value,
      name: name.value,
      lastname: lastname.value,
      phone: phone.value,
      image: image.value,
    );

    final roleIds = selectedRoles.map((role) => role.id ?? '').where((id) => id.isNotEmpty).toList();
    final responseUser = await userProvider.updateUser(updatedUser, roleIds);

    if (responseUser.success = true) {
      //Get.snackbar("Éxito", "Usuario actualizado correctamente");
      Get.snackbar(
        'Proceso terminado', 
       'Usuario actualizado correctamente',
        backgroundColor: Colors.green,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
      //Get.back(result: true);
    } else {
      //Get.snackbar("Error", "No se pudo actualizar el usuario");
      Get.snackbar(
        'Formulario no valido', 'La edición no se completo, revisa el mail o número único',
        backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
    }
  }

  // Simula una API o consulta para obtener todos los roles disponibles
  List<Rol> getAllRoles() {
    return [
      Rol(id: '1', name: 'Admin'),
      Rol(id: '2', name: 'Delivery'),
      Rol(id: '3', name: 'Cliente'),
    ];
  }
}
