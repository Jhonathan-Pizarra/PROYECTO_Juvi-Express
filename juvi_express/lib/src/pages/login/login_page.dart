import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70, // Ajustado para incluir el mensaje de soporte
        child: _textDontHaveAccount(),
      ),
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            children: [
              _imageAndTextRow(context),
            ],
          )
        ],
      ),
    );
  }

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageCover(),
            _textAppName(),
          ],
        ),
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Column(
      children: [
        Row(
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
            GestureDetector(
              onTap: () => con.goToRegisterPage(),
              child: Text(
                "Regístrate aquí",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5), // Espacio entre los textos
        _textSupportMessage(), // Mensaje de soporte agregado aquí
      ],
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, left: 50, right: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _textSupportMessage() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.help_outline, color: Colors.blue, size: 18),
          SizedBox(width: 5),
          Text(
            "¿Problemas? Llama al 0990803120",
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 10),
      child: Text(
        "Iniciar Sesión",
        style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black,
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.amber,
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
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.amber,
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
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: () => con.login(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.amber,
        ),
        child: Text(
          "Ingresar",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
