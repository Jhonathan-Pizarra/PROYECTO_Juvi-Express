import 'dart:convert';
import 'package:juvi_express/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? sessionToken;
  List<Rol>? roles = [];

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.sessionToken,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      lastname: json["lastname"],
      phone: json["phone"],
      image: json["image"],
      password: json["password"],
      sessionToken: json["session_token"],
      roles: json["roles"] == null
          ? []
          : json["roles"] is String
              ? List<Rol>.from(
                  jsonDecode(json["roles"]).map((model) => Rol.fromJson(model)))
              : List<Rol>.from(json["roles"].map((model) => Rol.fromJson(model))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "session_token": sessionToken,
        "roles": roles?.map((rol) => rol.toJson()).toList(),
      };

  static List<User> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => User.fromJson(item)).toList();
  }
}
