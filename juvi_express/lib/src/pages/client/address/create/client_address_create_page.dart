import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/client/address/create/client_address_create_controller.dart';

class ClientAddressCreatePage extends StatelessWidget {
  final ClientAddressCreateController con = Get.put(ClientAddressCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          'Nueva Dirección',
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: con.addressController,
              labelText: 'Dirección',
              icon: Icons.location_on,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: con.neighborhoodController,
              labelText: 'Barrio',
              icon: Icons.location_city,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: con.refPointController,
              labelText: 'Punto de referencia',
              icon: Icons.map,
              onTap: () => con.openGoogleMaps(context),
              focusNode: AlwaysDisabledFocusNode(),
            ),
            SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    VoidCallback? onTap,
    FocusNode? focusNode,
  }) {
    return TextField(
      controller: controller,
      onTap: onTap,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.teal), // Icono en teal
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      cursorColor: Colors.teal,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          con.createAddress();
        },
        style: ElevatedButton.styleFrom(
          //primary: Colors.teal, // Botón en teal
          //onPrimary: Colors.amber, // Texto del botón en amber
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Colors.amber
        ),
        child: Text(
          'Crear Dirección',
          style: TextStyle(
            fontSize: 16,
            //fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
    );
  }
}

// Clase para la referencia
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
