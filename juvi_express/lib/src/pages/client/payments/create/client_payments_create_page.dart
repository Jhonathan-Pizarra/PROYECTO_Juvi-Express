import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha
import 'package:juvi_express/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:juvi_express/src/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:path/path.dart';

class ClientPaymentsCreatePage extends StatelessWidget {
  ClientPaymentsCreateController con = Get.put(ClientPaymentsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Método de Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seleccione el método de pago:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Obx(() => Column(
              children: [
                RadioListTile(
                  value: 'transferencia',
                  groupValue: con.paymentMethod.value,
                  onChanged: (value) => con.selectPaymentMethod(value),
                  title: Text('Transferencia Bancaria'),
                ),
                if (con.paymentMethod.value == 'transferencia') ...[
                  SizedBox(height: 20),
                  _buildBankAccountInfo(),
                  Text(
                     'Sube el comprobante de transferencia',
                  ),
                  _imageTextRow(context),
                  // Agrega aquí cualquier otro campo necesario para la transferencia
                ],
                RadioListTile(
                  value: 'efectivo',
                  groupValue: con.paymentMethod.value,
                  onChanged: (value) => con.selectPaymentMethod(value),
                  title: Text('Pago en Efectivo'),
                ),
                if (con.paymentMethod.value == 'efectivo') ...[
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Monto disponible'),
                    onChanged: (value) => con.cashAmount = value,
                  ),
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => con.processPayment(context),
                  child: Text('Procesar Pago'),
                ),
              ],
            )),
          ],
        ),
      ),
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
        Text('Cuenta: xxx.xxxx.xxx'),
        Text('Banco: Produbanco'),
        Text('Tipo de Cuenta: Ahorros'),
        Text('Cédula: 1726368626'),
        Text('Fecha: $currentDate'),
        SizedBox(height: 20),
      ],
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
            _imagePayment(context),
            //_imageCover(),
            //SizedBox(width: 1), // Espacio entre la imagen y el texto
          ],
        ),
      ),
    );
  }



  Widget _imagePayment(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 30),
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () => con.showAlertDialog(context),
        child: GetBuilder<ClientPaymentsCreateController>(
          builder: (value) => CircleAvatar(
          backgroundImage: con.imageFile != null ?
          FileImage(con.imageFile!)
          : AssetImage('assets/img/user1.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
          ),
        )
      ),

    );
  }


}
