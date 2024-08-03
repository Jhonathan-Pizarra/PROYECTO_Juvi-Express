import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/client/profile/info/client_profile_info_controller.dart';

class ClientProfileInfoPage extends StatelessWidget {

  ClientProfileInfoController con = Get.put(ClientProfileInfoController());

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _buttonSignOut(),
          Column(
            children: [
              _imageTextRow(context), // Cambiamos esto
            ],
          )
        ],
      )),
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
            _imageUser(context),
            //_imageCover(),
            //SizedBox(width: 1), // Espacio entre la imagen y el texto
          ],
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 30),
      alignment: Alignment.topCenter,
      child: CircleAvatar(
          backgroundImage: con.user.value.image != null ?
          NetworkImage(con.user.value.image!)
          : AssetImage('assets/img/user1.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
          ),
        );
  }


//FORMULARIO REGISTRO

  Widget _boxForm(BuildContext context){
    
    return Container(
      height: MediaQuery.of(context).size.height*0.50,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.28,left: 50, right: 50),
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
            _textEmailUser(),
            _textPhoneUser(),
            _buttonUpdate(context)
          ],
        ),
      ),

    );

  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 10),
      child: Text('${con.user.value.name ?? ''} ${con.user.value.lastname ?? ''}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    );
  }

    Widget _textEmailUser() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: ListTile(
        leading: Icon(Icons.email), 
        title: Text(con.user.value.email ?? ''),
        subtitle: Text('Email')
      ),
    );
  }

    Widget _textPhoneUser() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20),
      child: ListTile(
        leading: Icon(Icons.phone), 
        title: Text(con.user.value.phone ?? ''),
        subtitle: Text('Telefono')
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
  }
*/

  Widget _buttonUpdate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ElevatedButton(
        onPressed: () => con.goToProfileUpdate(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.amber,
        ),
        child: Text(
          "Actualizar datos",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buttonSignOut(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () => con.signOut(),
          icon: Icon(
            Icons.power_settings_new,
            color: Colors.white,
            //size: 30,
            ),
          ),
      )
      
    );
  }

  
}