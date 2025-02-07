/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
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
                DataCell(Text(user.id?.toString() ?? '')),
                DataCell(Text(user.name ?? '')),
                DataCell(Text(user.email ?? '')),
                DataCell(Text(user.phone ?? '')),
                DataCell(Text(user.roles != null && user.roles!.isNotEmpty
                    ? user.roles!.map((role) => role.name ?? 'Sin nombre').join(', ')
                    : 'Sin rol')),
                DataCell(
                  ElevatedButton(
                    onPressed: () => controller.goToEditUserPage(user), //  Llama a la función correctamente
                    child: Text('Editar'),
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
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/pages/admin/users/admin_users_list_controller.dart';

class AdminUsersListPage extends StatelessWidget {
  final AdminUsersListController controller = Get.put(AdminUsersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usuarios',
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.teal, // Color atractivo para la app bar
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0), // Márgenes para la vista
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.teal.shade100), // Fondo de encabezado
              columnSpacing: 16.0, // Espacio entre las columnas
              columns: [
                DataColumn(label: _buildColumnHeader('ID')),
                DataColumn(label: _buildColumnHeader('Nombre')),
                DataColumn(label: _buildColumnHeader('Email')),
                DataColumn(label: _buildColumnHeader('Teléfono')),
                DataColumn(label: _buildColumnHeader('Rol')),
                DataColumn(label: _buildColumnHeader('Acción')),
              ],
              rows: controller.users.map((user) {
                return DataRow(
                  cells: [
                    _buildDataCell(user.id?.toString() ?? ''),
                    _buildDataCell(user.name ?? ''),
                    _buildDataCell(user.email ?? ''),
                    _buildDataCell(user.phone ?? ''),
                    _buildDataCell(user.roles != null && user.roles!.isNotEmpty
                        ? user.roles!.map((role) => role.name ?? 'Sin nombre').join(', ')
                        : 'Sin rol'),
                    DataCell(
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal, // Color del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Bordes redondeados
                          ),
                        ),
                        onPressed: () => controller.goToEditUserPage(user),
                        child: Text(
                          'Editar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }

  // Función para mejorar el estilo de las cabeceras
  Widget _buildColumnHeader(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16, 
        fontWeight: FontWeight.bold, 
        color: Colors.teal[700],
      ),
    );
  }

  // Función para mejorar la apariencia de las celdas
  DataCell _buildDataCell(String text) {
    return DataCell(
      Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
