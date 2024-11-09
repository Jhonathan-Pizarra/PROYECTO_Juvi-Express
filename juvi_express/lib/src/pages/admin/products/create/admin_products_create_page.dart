import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/pages/admin/products/create/admin_products_create_controller.dart';

class AdminProductsCreatePage extends StatelessWidget {
  final AdminProductsCreateController con = Get.put(AdminProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Producto',
          style: TextStyle(
            color: Colors.white, // Cambia el color del texto aquí
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: con.nameController,
              labelText: 'Nombre del Producto',
              icon: Icons.label,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: con.descriptionController,
              labelText: 'Descripción',
              icon: Icons.description,
              maxLines: 3,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: con.priceController,
              labelText: 'Precio',
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            _buildDropDownCategories(),
            SizedBox(height: 16),
            _buildImagePicker(1),
            SizedBox(height: 8),
            _buildImagePicker(2),
            SizedBox(height: 8),
            _buildImagePicker(3),
            SizedBox(height: 24),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.teal), // Color añadido aquí
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropDownCategories() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Categoría',
          border: OutlineInputBorder(),
        ),
        items: con.categories.map((category) {
          return DropdownMenuItem(
            value: category.id,
            child: Text(category.name ?? ''),
          );
        }).toList(),
        value: con.idCategory.value == '' ? null : con.idCategory.value,
        onChanged: (value) {
          con.idCategory.value = value.toString();
        },
      );
    });
  }

  Widget _buildImagePicker(int imageNumber) {
    return Obx(() {
      File? imageFile;
      if (imageNumber == 1) imageFile = con.imageFile1.value;
      if (imageNumber == 2) imageFile = con.imageFile2.value;
      if (imageNumber == 3) imageFile = con.imageFile3.value;

      return GestureDetector(
        onTap: () => con.showAlertDialog(Get.context!, imageNumber),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: imageFile != null
              ? Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.teal, // Color añadido aquí
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.createProduct(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.teal,
        ),
        child: Text(
          'Crear Producto',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
