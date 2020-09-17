import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_flutter/src/models/product_response.dart';
import 'package:my_flutter/src/services/header_interceptor.dart';

import 'package:http_parser/http_parser.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  NetworkService._internal();

  factory NetworkService() => _instance;

  static final Dio _dio = Dio()
    ..interceptors.addAll(
      [
        HeaderInterceptor(),
        LogInterceptor(),
      ],
    );

  static const baseURL = "https://cmpos-demo.herokuapp.com";

  Future<List<ProductResponse>> getStock() async {
    final url = '$baseURL/product';

    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      return productResponseFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<String> addProduct(File imageFile, ProductResponse product) async {
    final url = '$baseURL/product';

    FormData data = FormData.fromMap({
      "name": product.name,
      "price": product.price,
      "stock": product.stock,
      if (imageFile != null)
        "photo": await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType("image", "jpg"),
        ),
    });

    Response response = await _dio.post(url, data: data);

    if (response.statusCode == 201) {
      return "Add Successfully";
    } else {
      throw Exception('Add failed');
    }
  }
}
