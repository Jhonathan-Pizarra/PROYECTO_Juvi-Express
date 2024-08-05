import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/admin/categories/create/admin_categories_create_controller.dart';

class AdminCategoriesCreatePage extends StatelessWidget {

  AdminCategoriesCreateController con = Get.put(AdminCategoriesCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewCategory(context)
        ],
      ),
    );
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
      height: MediaQuery.of(context).size.height*0.50,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.34,left: 50, right: 50),
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
            _buttonCreate(context)
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
            Icon(Icons.category, size: 100)
          ],
        ),
      ),
    );
  }


  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 10),
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


  Widget _buttonCreate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: () => con.createCategory(),
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
}