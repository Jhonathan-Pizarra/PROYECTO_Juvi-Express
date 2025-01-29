import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/models/rol.dart'; // Asegúrate de que el modelo Rol esté importado
import 'package:juvi_express/src/pages/admin/users/admin_users_list_controller.dart';

class AdminUsersListPage extends StatelessWidget {
  final AdminUsersListController controller = Get.put(AdminUsersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Teléfono')),
              DataColumn(label: Text('Rol')),
              DataColumn(label: Text('Acción')),
            ],
            rows: controller.users.map((user) {
              return DataRow(cells: [
                DataCell(Text(user.id ?? '')),
                DataCell(Text(user.name ?? '')),
                DataCell(Text(user.email ?? '')),
                DataCell(Text(user.phone ?? '')),
                DataCell(Text(user.roles != null && user.roles!.isNotEmpty? user.roles!.map((role) {return role.name ?? 'Sin nombre';}).join(', ') : 'Sin rol')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          controller.goToEditUserPage(user);
                        },
                      ),
                    ],
                  ),
                ),
              ]);
            }).toList(),
          ),
        );
      }),
    );
  }



}
