import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/pages/admin/users/admin_user_edit_page.dart';
import 'package:juvi_express/src/pages/admin/users/admin_users_list_page.dart';
import 'package:juvi_express/src/providers/users_provider.dart'; // Tu provider de usuarios

class AdminUsersListController extends GetxController {
  var users = <User>[].obs;
  //final UsersProvider _usersProvider = UsersProvider();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
  // Llamamos al provider para obtener la lista de todos los usuarios
  List<User> usersList = await UsersProvider().findAllUsers();
  users.assignAll(usersList); // Recargar la lista
}

void goToEditUserPage(User user) async {
  //final result = await Get.toNamed('/admin/users/edit', arguments: user);
  final result = await Get.to(() => AdminUserEditPage(user: user));
  //final result = await Get.to(() => AdminUsersListPage());

   print("Resultado de la edición: $result"); // Verifica lo que se está retornando
   print("Resultado de la edición x2: $user"); // Verifica lo que se está retornando


    if (result == null) { // Si el usuario se editó, recargar la lista
      fetchUsers();
      //print("l usuario fue editado.");
    
    }else {
    print("l usuario no fue editado.");
    }
}

void updateUserInList(User updatedUser) {
  int index = users.indexWhere((u) => u.id == updatedUser.id);
  if (index != -1) {
    users[index] = updatedUser;
    users.refresh();
  }
}


}