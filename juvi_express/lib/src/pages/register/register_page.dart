import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/register/register_controller.dart';

class RegisterPage extends StatelessWidget {
  
  RegisterController con = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _buttonBack(),
          Column(
            children: [
              _imageTextRow(context), // Cambiamos esto
            ],
          )
        ],
      ),
    );
  }

//ELEMENTOS GENERALES
  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.32,
      color: Colors.amber,
    );
  }

  Widget _imageTextRow(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        //padding: EdgeInsets.symmetric(horizontal: 2), // Agrega padding horizontal
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageUser(),
            //_imageCover(),
            //SizedBox(width: 1), // Espacio entre la imagen y el texto
          ],
        ),
      ),
    );
  }

  Widget _imageUser(){
    return Container(
      margin: EdgeInsets.only(top: 30),
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () => {},
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/img/user1.png'),
          radius: 60,
          backgroundColor: Colors.white,
        ),
      ),

    );
  }

  Widget _buttonBack(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 2),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            //size: 30,
            ),
          ),
      )
      
    );
  }
//FORMULARIO REGISTRO

  Widget _boxForm(BuildContext context){
    
    return Container(
      height: MediaQuery.of(context).size.height*0.76,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.22,left: 50, right: 50),
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
            _textFieldEmail(),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            _buttonSignUp()
          ],
        ),
      ),

    );

  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 10),
      child: Text("Registrate",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    );
  }

/*
  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Correo electronico",
          prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }
*/

  Widget _textFieldEmail() {
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
          controller: con.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Correo electrónico",
            prefixIcon: Icon(Icons.email),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

/*
  Widget _textFieldPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Contraseña",
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
        ),
        style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
      ),
    );
  }
  */

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
          controller: con.namelController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Nombre",
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
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
          controller: con.lastNameController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Apellido",
            prefixIcon: Icon(Icons.person_outline),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
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
          controller: con.phoneController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Teléfono",
            prefixIcon: Icon(Icons.phone),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5), // Agregar margen vertical
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
          controller: con.passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Contraseña",
            prefixIcon: Icon(Icons.lock),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5), // Agregar margen vertical
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
          controller: con.confirmPasswordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Confirmar Contraseña",
            prefixIcon: Icon(Icons.lock),
            contentPadding: EdgeInsets.symmetric(vertical: 15), // Ajustar el padding vertical
          ),
          style: TextStyle(fontSize: 14), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _buttonSignUp(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: () => con.register(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.amber,
        ),
        child: Text(
          "Registrarse",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

}
