import 'dart:convert';
import 'dart:io';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:juvi_express/src/enviroment/enviroment.dart';
import 'package:juvi_express/src/models/response_api.dart';
import 'package:juvi_express/src/models/user.dart';

class UsersProvider extends GetConnect {
  final String _url = '${Enviroment.API_URL}api/users';
  final User _userSession = User.fromJson(GetStorage().read('user') ?? {});

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': _userSession.sessionToken ?? '',
      };

  Future<Response> create(User user) async {
    return await post(
      '$_url/create',
      user.toJson(),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Stream> createWithImage(User user, File image) async {
    final uri = Uri.http(Enviroment.API_URL_OLD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path),
      ))
      ..fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> update(User user) async {
    final response = await put(
      '$_url/updateWithoutImage',
      user.toJson(),
      headers: _headers,
    );

    if (response.body == null || response.statusCode == 401) {
      Get.snackbar('Error', response.statusCode == 401 ? 'No autorizado' : 'Error de actualización');
      return ResponseApi();
    }

    return ResponseApi.fromJson(response.body);
  }

  Future<Stream> updateWithImage(User user, File image) async {
    final uri = Uri.http(Enviroment.API_URL_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = _userSession.sessionToken ?? ''
      ..files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path),
      ))
      ..fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    final form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user),
    });
    final response = await post('$_url/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo crear el usuario');
      return ResponseApi();
    }

    return ResponseApi.fromJson(response.body);
  }

  Future<ResponseApi> login(String email, String password) async {
    final response = await post(
      '$_url/login',
      {'email': email, 'password': password},
      headers: {'Content-Type': 'application/json'},
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi();
    }

    return ResponseApi.fromJson(response.body);
  }

  Future<List<User>> findDeliveryMen() async {
    final response = await get(
      '$_url/findDeliveryMen',
      headers: _headers,
    );

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada', 'No tienes acceso a esta información');
      return [];
    }

    return User.fromJsonList(response.body);
  }

  Future<List<User>> findAllUsers() async {
    final response = await get(
      _url,
      headers: _headers,
    );

    if (response.statusCode == 401 || response.body == null) {
      Get.snackbar('Error', response.statusCode == 401 ? 'No autorizado' : 'No se encontraron usuarios');
      return [];
    }

    final data = response.body['data'] ?? [];
    return User.fromJsonList(data);
  }

  /*
  Future<bool> updateUser(User user) async {
    try {
      final response = await http.put(
        Uri.parse('$_url/${user.id}'),
        headers: _headers,
        body: json.encode(user),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error actualizando usuario: $e');
      return false;
    }
  }*/

  /*
  Future<ResponseApi> updateUser(User user, List<String> roleIds) async {
  final body = json.encode({
    "id": user.id,
    "email": user.email,
    "name": user.name,
    "lastname": user.lastname,
    "phone": user.phone,
    "image": user.image,
    "roles": json.encode(roleIds), // Convierte la lista de roles a un string JSON
  });

  final response = await put(
    '$_url/updateWithRoles',
    body,
    headers: _headers,
  );

  if (response.body == null || response.statusCode == 400) {
    Get.snackbar('Error', 'No se pudo actualizar el usuario');
    return ResponseApi();
  }

  return ResponseApi.fromJson(response.body);
}*/

Future<ResponseApi> updateUser(User user, List<String> roleIds) async {
  final body = {
    "user": {
      "id": user.id,
      "email": user.email,
      "name": user.name,
      "lastname": user.lastname,
      "phone": user.phone,
      "image": user.image,
      "password": user.password, // Asegúrate de incluir la contraseña si el backend la requiere
    },
    "roles": roleIds.map((id) => {"id": int.parse(id)}).toList(),
  };

  print("JSON enviado al backend: ${json.encode(body)}"); // Debug

  final response = await put(
    '$_url/updateWithRoles',
    json.encode(body), // Convierte a JSON antes de enviarlo
    headers: _headers,
  );

  if (response.body == null || response.statusCode == 400) {
    print("Error en la respuesta: ${response.body}");
    Get.snackbar('Error', 'No se pudo actualizar el usuario');
    return ResponseApi();
  }

  return ResponseApi.fromJson(response.body);
}


Future<ResponseApi> updateNotificationToken(String id, String token) async {
    final response = await put(
      '$_url/updateNotificationToken',
      {
        'id': id,
        'token': token
      },
      headers: _headers,
    );

    if (response.body == null || response.statusCode == 401) {
      Get.snackbar('Error', response.statusCode == 401 ? 'No autorizado' : 'Error de actualización');
      return ResponseApi();
    }

    return ResponseApi.fromJson(response.body);
  }


}
