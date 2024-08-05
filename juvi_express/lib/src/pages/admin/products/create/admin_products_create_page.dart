import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/models/category.dart';
import 'package:juvi_express/src/pages/admin/products/create/admin_products_create_controller.dart';


class AdminProductsCreatePage extends StatelessWidget {

  AdminProductsCreateController con = Get.put(AdminProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewCategory(context)
        ],
      ),
    ));
  }

//ELEMENTOS GENERALES
  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.32,
      color: const Color.fromARGB(255, 7, 135, 255),
    );
  }



//FORMULARIO REGISTRO

  Widget _boxForm(BuildContext context){
    
    return Container(
      height: MediaQuery.of(context).size.height*0.70,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.18,left: 50, right: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0,0.75) 
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldDescription(),
            _textFieldPrice(),
            _dropDownCategories(con.categories),
            Container(
              //margin: EdgeInsets.only(top: 20),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<AdminProductsCreateController>(
                  builder: (Value) => _cardImage(context, con.imageFile1, 1)
                ),
                SizedBox(width: 5),
                GetBuilder<AdminProductsCreateController>(
                  builder: (Value) => _cardImage(context, con.imageFile2, 2)
                ),
                SizedBox(width: 5),
                GetBuilder<AdminProductsCreateController>(
                  builder: (Value) => _cardImage(context, con.imageFile3, 3)
                ),
              ],
              ),
            ),
            _buttonCreate(context),
          ],
        ),
      ),

    );

  }

  Widget _textNewCategory(BuildContext context) {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Icon(Icons.food_bank, size: 100)
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 5),
      child: Text("Ingresar datos",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Agregar margen vertical
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.amber, // Cambiar el color principal
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            prefixIconColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.focused) ? Colors.amber : Colors.grey,
            ),
          ),
        ),
        child: TextField(
          controller: con.nameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Nombre",
            prefixIcon: Icon(Icons.category),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Agregar margen vertical
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.amber, // Cambiar el color principal
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            prefixIconColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.focused) ? Colors.amber : Colors.grey,
            ),
          ),
        ),
        child: TextField(
          controller: con.descriptionController,
          keyboardType: TextInputType.text,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Descripción",
            prefixIcon: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Icon(Icons.description),
            )
            //contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _textFieldPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Agregar margen vertical
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.amber, // Cambiar el color principal
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            prefixIconColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.focused) ? Colors.amber : Colors.grey,
            ),
          ),
        ),
        child: TextField(
          controller: con.priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Precio",
            prefixIcon: Icon(Icons.attach_money),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
         onPressed: () {
            con.createProduct(context);
          },
        //onPressed: () => con.createProduct(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.amber,
        ),
        child: Text(
          "Crear",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          "Seleccionar categoría",
          style: TextStyle(
            //color: Colors.black,
            fontSize: 14
          ),
        ),
        items: _dropDownItems(categories),
        //value: con.idCategory.value,
        value: con.idCategory.value == '' ? null : con.idCategory.value,
        onChanged: (option){
          con.idCategory.value = option.toString();
        },
      ),
    );

  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category){
      list.add(DropdownMenuItem(
        child: Text(category.name ?? ''),
        value: category.id,
        ));
    });

    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile){

    return GestureDetector(
        onTap: () => con.showAlertDialog(context, numberFile),
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(1),
            height: 80,
            width: MediaQuery.of(context).size.width * 0.18,
            child: imageFile != null
            ? Image.file(
              imageFile,
              fit: BoxFit.cover,
            )
            : Image(
              image: AssetImage('assets/img/cover_image.png'),
            )
          )
        )
       
      );
    
  }


}