import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/client/profile/update/client_profile_update_controller.dart';

class ClientProfileUpdatePage extends StatelessWidget {
  final ClientProfileUpdateController con = Get.put(ClientProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _buttonBack(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.35, // Ajustado para mover la imagen a la derecha
            child: _imageUser(context),
          ),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800,
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return GestureDetector(
      onTap: () => con.showAlertDialog(context),
      child: GetBuilder<ClientProfileUpdateController>(
        builder: (controller) => Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blueGrey.shade700, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundImage: con.imageFile != null
                ? FileImage(con.imageFile!)
                : con.user.image != null
                    ? NetworkImage(con.user.image!)
                    : AssetImage('assets/img/user1.png') as ImageProvider,
            backgroundColor: Colors.blueGrey.shade900,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back, color: Colors.white),
        padding: EdgeInsets.all(16),
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30, left: 20, right: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Actualizar Información",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
            SizedBox(height: 20),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            SizedBox(height: 20),
            _buttonUpdate(context),
          ],
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return _buildTextField(
      controller: con.nameController,
      icon: Icons.person,
      hintText: "Nombre",
    );
  }

  Widget _textFieldLastName() {
    return _buildTextField(
      controller: con.lastNameController,
      icon: Icons.person_outline,
      hintText: "Apellido",
    );
  }

  Widget _textFieldPhone() {
    return _buildTextField(
      controller: con.phoneController,
      icon: Icons.phone,
      hintText: "Teléfono",
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueGrey.shade700),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.updateInfo(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber, // Color de fondo ámbar
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          "Actualizar",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
