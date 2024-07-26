//import 'dart:js_interop';

import 'package:get/get.dart';
import 'package:juvi_express/src/enviroment/enviroment.dart';
import 'package:juvi_express/src/models/user.dart';

class UsersProvider extends GetConnect {

  String url = Enviroment.API_URL + "api/users";

  Future<Response> create (User user) async {
    Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {
        'Content-Type': "application/json"
      }
    );

    return response;
  }
}