import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/pages/admin/users/admin_user_edit_page.dart';
import 'package:juvi_express/src/providers/users_provider.dart'; // Tu provider de usuarios

class AdminUsersListController extends GetxController {
  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
  // Llamamos al provider para obtener la lista de todos los usuarios
  List<User> usersList = await UsersProvider().findAllUsers();
  users.value = usersList; // Asignamos la lista de usuarios al observable
}

void goToEditUserPage(User user) {
  Get.to(() => AdminUserEditPage(user: user));
}

}