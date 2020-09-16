// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

List<ProductResponse> productResponseFromJson(String str) => List<ProductResponse>.from(json.decode(str).map((x) => ProductResponse.fromJson(x)));

String productResponseToJson(List<ProductResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponse {
  ProductResponse({
    this.id,
    this.name,
    this.image,
    this.stock,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String image;
  int stock;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    stock: json["stock"],
    price: json["price"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "stock": stock,
    "price": price,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
