import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/models/product.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/providers/categories_provider.dart';
import 'package:juvi_express/src/providers/products_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AdminProductsCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();
  ImagePicker picker = ImagePicker();

  Rx<File?> imageFile1 = Rx<File?>(null);
  Rx<File?> imageFile2 = Rx<File?>(null);
  Rx<File?> imageFile3 = Rx<File?>(null);

  var idCategory = ''.obs;
  RxList<Category> categories = <Category>[].obs;

  AdminProductsCreateController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  void createProduct(BuildContext context) async {
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    ProgressDialog progressDialog = ProgressDialog(context: context);

    if (isValidForm(name, description, price)) {
      Product product = Product(
        name: name,
        description: description,
        price: double.parse(price),
        idCategory: idCategory.value,
      );

      progressDialog.show(max: 100, msg: "Espere un momento...");

      List<File> images = [];
      if (imageFile1.value != null) images.add(imageFile1.value!);
      if (imageFile2.value != null) images.add(imageFile2.value!);
      if (imageFile3.value != null) images.add(imageFile3.value!);

      Stream stream = await productsProvider.create(product, images);
      stream.listen((res) {
        progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Creado con éxito', responseApi.message ?? '');
        if (responseApi.success == true) {
          clearForm();
        }
      });
    }
  }

  bool isValidForm(String name, String description, String price) {
    if (name.isEmpty) {
      Get.snackbar('Formulario no válido', 'Ingrese un nombre');
      return false;
    }
    if (description.isEmpty) {
      Get.snackbar('Formulario no válido', 'Ingrese la descripción');
      return false;
    }
    if (price.isEmpty) {
      Get.snackbar('Formulario no válido', 'Ingrese un precio');
      return false;
    }
    if (idCategory.value.isEmpty) {
      Get.snackbar('Formulario no válido', 'Seleccione una categoría');
      return false;
    }
    if (imageFile1.value == null && imageFile2.value == null && imageFile3.value == null) {
      Get.snackbar('Formulario no válido', 'Ingrese al menos una imagen');
      return false;
    }

    return true;
  }

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    imageFile1.value = null;
    imageFile2.value = null;
    imageFile3.value = null;
    idCategory.value = '';
    update();
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      File newFile = File(image.path);
      if (numberFile == 1) {
        imageFile1.value = newFile;
      } else if (numberFile == 2) {
        imageFile2.value = newFile;
      } else if (numberFile == 3) {
        imageFile3.value = newFile;
      }
      update();
    }
  }

  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery, numberFile);
      },
      child: Text('GALERÍA', style: TextStyle(color: Colors.black)),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera, numberFile);
      },
      child: Text('CÁMARA', style: TextStyle(color: Colors.black)),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opción'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }
}
