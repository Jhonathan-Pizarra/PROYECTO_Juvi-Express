import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/pages/admin/products/create/admin_products_create_controller.dart';
import 'package:juvi_express/src/providers/categories_provider.dart';


class AdminCategoriesCreateController extends GetxController {

  
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();


  void createCategory() async {

    String name = nameController.text;
    String description = descriptionController.text;
    print('NAME: ${name}');
    print('DESCRIPTION: ${description}');

    if (name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(
        name: name,
        description: description
      );

      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Proceso terminado', responseApi.message ?? '');

      if (responseApi.success == true) {
        clearForm();
        // Emite una señal para actualizar las categorías
         Get.find<AdminProductsCreateController>().getCategories();
      }

    }
    else {
      Get.snackbar('Formulario no valido', 'Ingresa todos los campos para crear la categoria');
    }

  }

  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';

  }

}