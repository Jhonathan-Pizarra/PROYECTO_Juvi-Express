import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            children: [
              _imageAndTextRow(context), // Cambiamos esto
            ],
          )
        ],
      ),
    );
  }

//SCREEN GENERAL
  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.32,
      color: Colors.amber,
    );
  }

  Widget _textAppName() {
    return Flexible(
      child: Text(
        'Bienvenido a Juvi-Express',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Image.asset(
          'assets/img/deliveryC.png',
          width: 200,
          height: 220,
        ),
      ),
    );
  }

  Widget _imageAndTextRow(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        //padding: EdgeInsets.symmetric(horizontal: 2), // Agrega padding horizontal
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageCover(),
            //SizedBox(width: 1), // Espacio entre la imagen y el texto
            _textAppName(),
          ],
        ),
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿No tienes cuenta?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Text(
          "Regístrate aquí",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

//LOGIN SECTION
  Widget _boxForm(BuildContext context){
    
    return Container(
      height: MediaQuery.of(context).size.height*0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35,left: 50, right: 50),
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
            _textFieldPassword(),
            _buttonLogin()
          ],
        ),
      ),

    );

  }

  Widget _textYourInfo(){
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 10),
      child: Text(
        "Iniciar Sesion",
        style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black,
        )
      ),
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
  }*/


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

  Widget _buttonLogin(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.amber,
        ),
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
          ),
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



}
