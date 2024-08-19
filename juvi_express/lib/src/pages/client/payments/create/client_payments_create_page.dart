import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:juvi_express/src/pages/client/payments/create/client_payments_create_controller.dart';

class ClientPaymentsCreatePage extends StatelessWidget {


  ClientPaymentsCreateController con = Get.put(ClientPaymentsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Implementar Pago de la orden"),
      ),
    );

  }

}
