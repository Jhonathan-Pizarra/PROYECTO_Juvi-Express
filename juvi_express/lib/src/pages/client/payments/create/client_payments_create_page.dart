import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:juvi_express/src/pages/client/payments/create/client_payments_create_controller.dart';

class ClientPaymentsCreatePage extends StatelessWidget {
  final ClientPaymentsCreateController con = Get.put(ClientPaymentsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: Text(
          'Método de pago',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seleccione el método de pago:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Obx(() => Column(
                children: [
                  _buildRadioTile(
                    'Transferencia Bancaria',
                    'transferencia',
                    context,
                  ),
                  if (con.paymentMethod.value == 'transferencia') ...[
                    SizedBox(height: 20),
                    _buildBankAccountInfo(),
                    SizedBox(height: 20),
                    Text(
                      'Sube el comprobante de transferencia',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    _imageTextRow(context),
                  ],
                  _buildRadioTile(
                    'Pago en efectivo',
                    'efectivo',
                    context,
                  ),
                  if (con.paymentMethod.value == 'efectivo') ...[
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Monto disponible',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      onChanged: (value) => con.cashAmount = value,
                    ),
                  ],
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => con.processPayment(context),
                      child: Text(
                        'Procesar Pago',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal, // Color de fondo teal
                        padding: EdgeInsets.symmetric(vertical: 15), // Aumenta el padding vertical
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bordes redondeados
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile(String title, String value, BuildContext context) {
    return RadioListTile(
      value: value,
      groupValue: con.paymentMethod.value,
      onChanged: (value) => con.selectPaymentMethod(value),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      activeColor: Colors.teal, // Color del radio cuando está seleccionado
    );
  }

  Widget _buildBankAccountInfo() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String currentDate = dateFormat.format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información de la Cuenta Bancaria:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text('Cuenta: 12186133789'),
        Text('Banco: Produbanco'),
        Text('Tipo de Cuenta: Ahorros'),
        Text('Cédula: 1726368626'),
        Text('Fecha: $currentDate'),
      ],
    );
  }

  Widget _imageTextRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imagePayment(context),
        ],
      ),
    );
  }

  Widget _imagePayment(BuildContext context) {
    return GestureDetector(
      onTap: () => con.showAlertDialog(context),
      child: GetBuilder<ClientPaymentsCreateController>(
        builder: (value) => Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: con.imageFile != null
                  ? FileImage(con.imageFile!)
                  : AssetImage('assets/img/upload-image2.png') as ImageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10), // Cambiar a cuadrado
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300), // Borde para destacar la imagen
          ),
        ),
      ),
    );
  }
}
