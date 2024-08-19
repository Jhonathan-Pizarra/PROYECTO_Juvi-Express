import 'dart:convert';

Product productFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    print('JSON Decodificado: $jsonData');
    if (jsonData is Map<String, dynamic>) {
      return Product.fromJson(jsonData);
    } else {
      throw FormatException('El JSON decodificado no es un Map<String, dynamic>');
    }
  } catch (e) {
    print('Error al decodificar el JSON: $e');
    rethrow;
  }
}

String productToJson(Product data) {
  try {
    final jsonData = data.toJson();
    print('Datos JSON: $jsonData');
    return json.encode(jsonData);
  } catch (e) {
    print('Error al codificar los datos a JSON: $e');
    rethrow;
  }
}

class Product {
  String? id;
  String? name;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  String? idCategory;
  double? price;
  int? quantity;

  Product({
    this.id,
    this.name,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.idCategory,
    this.price,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    print('Datos JSON en fromJson: $json');
    return Product(
      id: json["id"] as String?,
      name: json["name"] as String?,
      description: json["description"] as String?,
      image1: json["image1"] as String?,
      image2: json["image2"] as String?,
      image3: json["image3"] as String?,
      idCategory: json["id_category"] as String?,
      price: (json["price"] as num?)?.toDouble(),
      quantity: json["quantity"] as int?,
    );
  }

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    if (jsonList is List) {
      print('Lista JSON en fromJsonList: $jsonList');
      List<Product> toList = [];
      
      for (var item in jsonList) {
        if (item is Map<String, dynamic>) {
          try {
            Product product = Product.fromJson(item);
            toList.add(product);
          } catch (e) {
            print('Error al convertir item a Product: $e');
          }
        } else {
          print('Item en la lista no es un Map<String, dynamic>: $item');
        }
      }
      
      return toList;
    } else {
      throw FormatException('jsonList no es una lista');
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "id_category": idCategory,
    "price": price,
    "quantity": quantity,
  };
}
