import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/client/profile/info/client_profile_info_controller.dart';

class ClientProfileInfoPage extends StatelessWidget {
  final ClientProfileInfoController con = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(() => Stack(
        children: [
          _backgroundCover(context),
          _profileCard(context),
          _buttons(),
        ],
      )),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.teal,
      child: Center(
        child: Text(
          'Perfil del Usuario',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _profileCard(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.25), // Espacio para el encabezado
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Column(
              children: [
                _profileImage(),
                SizedBox(height: 16),
                _userDetails(),
                SizedBox(height: 24),
                _buttonUpdate(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileImage() {
    return CircleAvatar(
      backgroundImage: con.user.value.image != null 
          ? NetworkImage(con.user.value.image!)
          : AssetImage('assets/img/user1.png') as ImageProvider,
      radius: 60,
      backgroundColor: Colors.white,
    );
  }

  Widget _userDetails() {
    return Column(
      children: [
        Text(
          '${con.user.value.name ?? ''} ${con.user.value.lastname ?? ''}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          con.user.value.email ?? '',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        SizedBox(height: 8),
        Text(
          con.user.value.phone ?? '',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buttonUpdate() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.goToProfileUpdate(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.teal,
        ),
        child: Text(
          "Actualizar Datos",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Positioned(
      top: 40,
      right: 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.supervised_user_circle, color: Colors.white),
            onPressed: () => con.goToRoles(),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.power_settings_new, color: Colors.white),
            onPressed: () => con.signOut(),
          ),
        ],
      ),
    );
  }
}
