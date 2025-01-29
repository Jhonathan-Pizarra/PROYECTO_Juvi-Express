import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/models/rol.dart';
import 'package:juvi_express/src/providers/users_provider.dart';


class AdminUserEditController extends GetxController {
  final UsersProvider userProvider = UsersProvider();

  final formKey = GlobalKey<FormState>();

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxList<Rol> roles = <Rol>[].obs; // Todos los roles disponibles
  RxList<Rol> selectedRoles = <Rol>[].obs; // Roles seleccionados por el usuario

  late User user;

  void loadUserData(User user) {
    this.user = user;
    name.value = user.name ?? '';
    email.value = user.email ?? '';
    phone.value = user.phone ?? '';

    // Cargar roles del usuario
    roles.value = getAllRoles(); // Método para obtener todos los roles del sistema
    //selectedRoles.value = user.roles ?? []; // Marcar roles ya asignados
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

  void updateUser() async {
    if (!formKey.currentState!.validate()) return;

    user.name = name.value;
    user.email = email.value;
    user.phone = phone.value;

    // Actualizar roles del usuario
    user.roles = selectedRoles;

    final response = await userProvider.updateUser(user);

    if (response) {
      Get.snackbar('Éxito', 'Usuario actualizado correctamente.');
      Get.back(); // Volver a la lista
    } else {
      Get.snackbar('Error', 'No se pudo actualizar el usuario.');
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
