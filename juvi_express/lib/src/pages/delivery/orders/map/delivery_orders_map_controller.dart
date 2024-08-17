import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
//import 'package:location/location.dart' as location;

class DeliveryOrdersMapController extends GetxController {

  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-0.2718095, -78.5423117),
    zoom: 14
  );

  LatLng? addressLatLng;
  var addressName = ''.obs;
  Completer<GoogleMapController> mapController = Completer();
  Position? position;

  DeliveryOrdersMapController() {
    checkGPS(); // VERIFICAR SI EL GPS ESTA ACTIVO
  }

  Future setLocationDraggableInfo() async {

    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;

    List<Placemark> address = await placemarkFromCoordinates(lat, lng);

    if (address.isNotEmpty) {
      String direction = address[0].thoroughfare ?? '';
      String street = address[0].subThoroughfare ?? '';
      String city = address[0].locality ?? '';
      String department = address[0].administrativeArea ?? '';
      String country = address[0].country ?? '';
      addressName.value = '$direction #$street, $city, $department';
      addressLatLng = LatLng(lat, lng);
      print('LAT Y LNG: ${addressLatLng?.latitude ?? 0} ${addressLatLng?.longitude ?? 0}');
    }

  }

  void selectRefPoint(BuildContext context){

    if (addressLatLng != Null) {
      Map<String, dynamic> data = {
      'address': addressName.value,
      'lat': addressLatLng!.latitude,
      'lng':  addressLatLng!.longitude,
     };
     Navigator.pop(context, data);
    }

  }

  void checkGPS() async {

    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled == true) {
      updateLocation();
    }
    else {
      //bool locationGPS = await location.Location().requestSe
      //Pernsa bien como implementar este de habilitar la hubicacion, solicitar activar la ubivacion
      // Si la ubicación no está habilitada, solicita al usuario que la habilite
      LocationPermission permission = await Geolocator.requestPermission();
    
      /*bool locationGPS = false;
      if (locationGPS == true) {
        updateLocation();
      }
      */
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // Si el usuario concede el permiso, actualiza la ubicación
      updateLocation();
    } else {
      // Puedes manejar el caso en el que el usuario no concede el permiso
      print("El usuario no concedió el permiso de ubicación.");
    }

    }
  }

  void updateLocation() async {
    try{
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition(); // LAT Y LNG (ACTUAL)
      animateCameraPosition(position?.latitude ?? -0.2718095, position?.longitude ?? -78.5423117);
    } catch(e) {
      print('Error: ${e}');
    }
  }

  Future animateCameraPosition(double lat, double lng) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(lat, lng),
          zoom: 13,
          bearing: 0
      )
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }


  void onMapCreate(GoogleMapController controller){
    mapController.complete(controller);
  }


  


}