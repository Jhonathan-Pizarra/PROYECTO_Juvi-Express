import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/admin/categories/create/admin_categories_create_controller.dart';

class AdminCategoriesCreatePage extends StatelessWidget {
  AdminCategoriesCreateController con = Get.put(AdminCategoriesCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // Espacio entre el margen superior y el primer elemento
            _header(),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: _form(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.category, size: 120, color: Colors.teal),
          SizedBox(height: 16),
          Text(
            'Nueva Categoría',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ],
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFieldName(),
          SizedBox(height: 16),
          _textFieldDescription(),
          SizedBox(height: 24),
          _buttonCreate(context),
          SizedBox(height: 80), // Espacio adicional debajo del botón
        ],
      ),
    );
  }

  Widget _textFieldName() {
    return TextField(
      controller: con.nameController,
      decoration: InputDecoration(
        labelText: 'Nombre',
        prefixIcon: Icon(Icons.category, color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _textFieldDescription() {
    return TextField(
      controller: con.descriptionController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Descripción',
        prefixIcon: Icon(Icons.description, color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.createCategory(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.teal,
        ),
        child: Text('Crear Categoría', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
