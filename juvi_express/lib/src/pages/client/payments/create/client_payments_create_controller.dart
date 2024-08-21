import 'package:get/get.dart';

class ClientPaymentsCreateController extends GetxController {
  var paymentMethod = ''.obs;
  String receipt = '';
  String cashAmount = '';

  void selectPaymentMethod(String? method) {
    paymentMethod.value = method ?? '';
  }

  void processPayment() {
    if (paymentMethod.value == 'transferencia') {
      // Lógica para manejar la transferencia bancaria
      print('Método de pago: Transferencia Bancaria');
      print('Comprobante: $receipt');
    } else if (paymentMethod.value == 'efectivo') {
      // Lógica para manejar el pago en efectivo
      print('Método de pago: Efectivo');
      print('Monto disponible: $cashAmount');
    }
  }
}
