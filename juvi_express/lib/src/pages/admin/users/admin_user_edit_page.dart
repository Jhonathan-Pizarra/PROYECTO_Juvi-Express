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
