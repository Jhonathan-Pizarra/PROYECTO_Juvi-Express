import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juvi_express/src/models/address.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';
import 'package:juvi_express/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:juvi_express/src/pages/client/address/map/client_address_map_page.dart';
import 'package:juvi_express/src/providers/address_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController{

  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  double latRefPoint = 0;
  double lngRefPoint = 0;
  User user = User.fromJson(GetStorage().read('user') ?? {});
  AddressProvider addressProvider = AddressProvider();
  ClientAddressListController clientAddressListController = Get.find();

  /*
  void openGoogleMaps(BuildContext context) async {

    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
      context: context, 
      builder: (context) => ClientAddressMapPage(),
      isDismissible: false,
      enableDrag: false
    );


    print('ref point map ${refPointMap}');
    refPointController.text = refPointMap['address'];
    latRefPoint = refPointMap['lat'];
    lngRefPoint = refPointMap['lng'];
    
  }*/

  void openGoogleMaps(BuildContext context) async {
  Map<String, dynamic>? refPointMap = await showMaterialModalBottomSheet(
      context: context, 
      builder: (context) => ClientAddressMapPage(),
      isDismissible: false,
      enableDrag: false
    );

    if (refPointMap != null) {
      print('ref point map ${refPointMap}');
      refPointController.text = refPointMap['address'] ?? '';
      latRefPoint = refPointMap['lat'] ?? 0.0;
      lngRefPoint = refPointMap['lng'] ?? 0.0;
    } else {
      print('No data returned from bottom sheet.');
      // Maneja el caso donde refPointMap es null, si es necesario
    }
  }

  void createAddress() async {
  String addressName = addressController.text;
  String neighborhood = neighborhoodController.text;

  if (isValidForm(addressName, neighborhood)) {
    Address address = Address(
      address: addressName,
      neighborhood: neighborhood,
      lat: latRefPoint,
      lng: lngRefPoint,
      idUser: user.id,
    );

    ResponseApi? responseApi = await addressProvider.create(address);

    if (responseApi != null) {
      Fluttertoast.showToast(
          msg: responseApi.message ?? '',
          toastLength: Toast.LENGTH_LONG,
      );

      if (responseApi.success == true) {
        address.id = responseApi.data;
        GetStorage().write('address', address.toJson());

        clientAddressListController.update();

        Get.back();
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Error: No se pudo crear la dirección',
          toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}

  /*
  void createAddress() async {
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;

    if (isValidForm(addressName, neighborhood)) {
      Address address = Address(
        address: addressName,
        neighborhood: neighborhood,
        lat: latRefPoint,
        lng: lngRefPoint,
        idUser: user.id
      );

      ResponseApi responseApi = await addressProvider.create(address);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

      if (responseApi.success == true) {
        address.id = responseApi.data;
        GetStorage().write('address', address.toJson());

        clientAddressListController.update();

        Get.back();
      }

    }
  }*/

  bool isValidForm(String address, String neighborhood) {
    if (address.isEmpty){
      //Get.snackbar('Formulario no valido', 'Ingresa el nombre de la direccion');
      Get.snackbar(
        'Formulario no valido', 'Ingresa un nombre a la direccion',
        backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
      
      return false;
    }
    if (neighborhood.isEmpty){
      //Get.snackbar('Formulario no valido', 'Ingresa el nombre del barrio');
      Get.snackbar(
        'Formulario no valido', 'Ingresa el nombre del barrio',
        backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
      
      return false;
    }
    if (latRefPoint == 0){
      //Get.snackbar('Formulario no valido', 'Selecciona el punto de referencia');
      Get.snackbar(
        'Formulario no valido', 'Selecciona el punto de referencia',
        backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
      return false;
    }
    if (lngRefPoint == 0){
      //Get.snackbar('Formulario no valido', 'Selecciona el punto de referencia');
      Get.snackbar(
        'Formulario no valido', 'Selecciona el punto de referencia',
        backgroundColor: Colors.deepPurple,  // Color de fondo del Snackbar
        colorText: Colors.white,  // Color del texto
        snackPosition: SnackPosition.BOTTOM,  // Posición del Snackbar
        borderRadius: 8,  // Bordes redondeados
        margin: EdgeInsets.all(10),  // Márgenes alrededor
        animationDuration: Duration(milliseconds: 300),  // Duración de la animación
        duration: Duration(seconds: 3),  // Duración visible
      );
      return false;
    }

    return true;
  }

}