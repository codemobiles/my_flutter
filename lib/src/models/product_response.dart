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
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    stock: json["stock"] == null ? null : json["stock"],
    price: json["price"] == null ? null : json["price"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "stock": stock == null ? null : stock,
    "price": price == null ? null : price,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
