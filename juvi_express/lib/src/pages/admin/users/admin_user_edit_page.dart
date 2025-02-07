/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/models/rol.dart';
import 'package:juvi_express/src/pages/admin/users/admin_user_edit_controller.dart';

class AdminUserEditPage extends StatelessWidget {
  final User user;
  final AdminUserEditController controller = Get.put(AdminUserEditController());

  AdminUserEditPage({required this.user});

  @override
  Widget build(BuildContext context) {
    controller.loadUserData(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: user.name,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) => controller.name.value = value,
                ),
                TextFormField(
                  initialValue: user.email,
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) => controller.email.value = value,
                ),
                TextFormField(
                  initialValue: user.phone,
                  decoration: InputDecoration(labelText: 'Teléfono'),
                  onChanged: (value) => controller.phone.value = value,
                ),
                SizedBox(height: 16),
                Text(
                  'Roles',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  return Column(
                    children: controller.roles.map((role) {
                      return CheckboxListTile(
                        title: Text(role.name ?? 'Sin nombre'),
                        value: controller.selectedRoles.contains(role),
                        onChanged: (isSelected) {
                          controller.toggleRoleSelection(role, isSelected ?? false);
                        },
                      );
                    }).toList(),
                  );
                }),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.updateUser,
                  child: Text('Guardar Cambios'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/models/rol.dart';
import 'package:juvi_express/src/pages/admin/users/admin_user_edit_controller.dart';

class AdminUserEditPage extends StatelessWidget {
  final User user;
  final AdminUserEditController controller = Get.put(AdminUserEditController());

  AdminUserEditPage({required this.user});

  @override
  Widget build(BuildContext context) {
    controller.loadUserData(user);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Usuario',
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal, // Color de fondo de la AppBar
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField(
                  label: 'Nombre',
                  initialValue: user.name,
                  onChanged: (value) => controller.name.value = value,
                ),
                _buildTextFormField(
                  label: 'Email',
                  initialValue: user.email,
                  onChanged: (value) => controller.email.value = value,
                ),
                _buildTextFormField(
                  label: 'Teléfono',
                  initialValue: user.phone,
                  onChanged: (value) => controller.phone.value = value,
                ),
                SizedBox(height: 16),
                Text(
                  'Roles',
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.teal[700], // Color ámbar en el texto de Roles
                  ),
                ),
                Obx(() {
                  return Column(
                    children: controller.roles.map((role) {
                      return CheckboxListTile(
                        title: Text(role.name ?? 'Sin nombre'),
                        value: controller.selectedRoles.contains(role),
                        onChanged: (isSelected) {
                          controller.toggleRoleSelection(role, isSelected ?? false);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.amber, // Color ámbar en el checkbox
                      );
                    }).toList(),
                  );
                }),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: controller.updateUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Color del botón
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Guardar Cambios',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.teal[700]), // Etiqueta en color ámbar
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2), // Borde enfocado en color ámbar
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
