import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:juvi_express/src/models/order.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/providers/orders_provider.dart';
import 'package:juvi_express/src/enviroment/enviroment.dart';
import 'package:socket_io_client/socket_io_client.dart';
//import 'package:location/location.dart';
//import 'package:location/location.dart' as location;

class DeliveryOrdersMapController extends GetxController {

  Socket socket = io('${Enviroment.API_URL}orders/delivery', <String, dynamic> {
    'transports': ['websocket'],
    'autoConnect': false
  });

  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-0.2718095, -78.5423117),
    zoom: 14
  );

  LatLng? addressLatLng;
  var addressName = ''.obs;
  Completer<GoogleMapController> mapController = Completer();
  Position? position;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  BitmapDescriptor? deliveryMarker;
  BitmapDescriptor? homeMarker;
  Order order = Order.fromJson(Get.arguments['order'] ?? {});
  OrdersProvider ordersProvider = OrdersProvider();

  StreamSubscription? positionSubscribe;

  Set<Polyline> polylines = <Polyline>{}.obs;
  List<LatLng> points = [];

  double distanceBetween = 0.0;
  bool isClose = false;

  Future<BitmapDescriptor> createMarkerFromAssets(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(
        configuration, path
    );

    return descriptor;
  }

  DeliveryOrdersMapController() {
    print('Order: ${order.toJson()}');

    checkGPS(); // VERIFICAR SI EL GPS ESTA ACTIVO
    connectAndListen();
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

  /*
  void selectRefPoint(BuildContext context){

    if (addressLatLng != Null) {
      Map<String, dynamic> data = {
      'address': addressName.value,
      'lat': addressLatLng!.latitude,
      'lng':  addressLatLng!.longitude,
     };
     Navigator.pop(context, data);
    }

  }*/

  void checkGPS() async {

    deliveryMarker = await createMarkerFromAssets('assets/img/delivery_little.png');
    homeMarker = await createMarkerFromAssets('assets/img/home.png');


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
      saveLocation();
      animateCameraPosition(position?.latitude ?? -0.2718095, position?.longitude ?? -78.5423117);

      addMarker(
          'delivery',
          position?.latitude ?? -0.2718095,
          position?.longitude ?? -78.5423117,
          'Tu posicion',
          '',
          deliveryMarker!
      );

      addMarker(
          'home',
          order.address?.lat ?? 1.2004567,
          order.address?.lng ?? -77.2787444,
          'Lugar de entrega',
          '',
          homeMarker!
      );

      LatLng from = LatLng(position!.latitude, position!.longitude);
      LatLng to = LatLng(order.address?.lat ?? 1.2004567, order.address?.lng ?? -77.2787444);

      setPolylines(from, to);

      LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 1
      );


      positionSubscribe = Geolocator.getPositionStream(
          locationSettings: locationSettings
      ).listen((Position pos) { // POSICION EN TIEMPO REAL
        position = pos;

        addMarker(
          'delivery',
          position?.latitude ?? -0.2718095,
          position?.longitude ?? -78.5423117,
          'Tu posicion',
          '',
          deliveryMarker!
      );

      animateCameraPosition(position?.latitude ?? -0.2718095, position?.longitude ?? -78.5423117);

      emitPosition();
      isCloseToDeliveryPosition();

      });

    
    } catch(e) {
      print('Error: ${e}');
    }
  }

  void updateToDelivered() async {
      if (distanceBetween <= 200) {
        ResponseApi responseApi = await ordersProvider.updateToDelivered(order);
        Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
        if (responseApi.success == true) {
          emitToDelivered();
          Get.offNamedUntil('/delivery/home', (route) => false);
        }
      }
      else {
        Get.snackbar('Operacion no permitida', 'Debes estar mas cerca a la posicion de entrega del pedidio');
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

  void addMarker(
      String markerId,
      double lat,
      double lng,
      String title,
      String content,
      BitmapDescriptor iconMarker
    ) {
      MarkerId id = MarkerId(markerId);
      Marker marker = Marker(
          markerId: id,
          icon: iconMarker,
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: title, snippet: content)
      );

      markers[id] = marker;

      update();
    }

  void saveLocation() async {
    if (position != null) {
      order.lat = position!.latitude;
      order.lng = position!.longitude;
      await ordersProvider.updateLatLng(order);
    }
  }

  //Dibujar ruta
  Future<void> setPolylines(LatLng from, LatLng to) async {

    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);

    PolylineRequest polylineRequest = PolylineRequest(
      mode: TravelMode.driving,    // Modo de transporte
      alternatives: false,         // Si deseas rutas alternativas
      avoidFerries: false,         // Evitar transbordadores
      avoidTolls: false,           // Evitar peajes
      avoidHighways: false, 
      origin: pointFrom, 
      destination: pointTo,        // Evitar autopistas
    );

    // Llamar al método getRouteBetweenCoordinates con el request completo
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      googleApiKey: Enviroment.API_KEY_MAPS,  // Tu API Key de Google Maps
      request: polylineRequest          // Pasar el PolylineRequest
    );

    if (result.status == 'OK') {
      for (PointLatLng point in result.points) {
        points.add(LatLng(point.latitude, point.longitude));
      }

      Polyline polyline = Polyline(
        polylineId: PolylineId('poly'),
        color: Colors.red,
        points: points,
        width: 5
      );

      polylines.add(polyline);
      update();
    } else {
      print('Error al obtener la ruta: ${result.errorMessage}');
    }
  }

  void centerPosition() {
    if (position != null) {
      animateCameraPosition(position!.latitude, position!.longitude);
    }
  }

  //Llamada telefonica
  void callNumber() async{
    String number = order.client?.phone ?? ''; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void connectAndListen() {
    socket.connect();
    socket.onConnect((data) {
      print('ESTE DISPISITIVO SE CONECTO A SOCKET IO');
    });
  }

  void emitPosition() {
    if (position != null) {
      socket.emit('position', {
        'id_order': order.id,
        'lat': position!.latitude,
        'lng': position!.longitude,
      });
    }
  }

  void isCloseToDeliveryPosition() {

      if (position != null) {
        distanceBetween = Geolocator.distanceBetween(
            position!.latitude,
            position!.longitude,
            order.address!.lat!,
            order.address!.lng!
        );

        print('distanceBetween ${distanceBetween}');

        if (distanceBetween <= 200 && isClose == false) {
          isClose = true;
          update();
        }

      }

  }

  void emitToDelivered() {
    socket.emit('delivered', {
      'id_order': order.id,
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    socket.disconnect();
    positionSubscribe?.cancel();
  }

}