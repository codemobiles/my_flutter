import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_flutter/src/models/product_response.dart';
import 'package:my_flutter/src/services/header_interceptor.dart';

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

  static const _baseURL = "https://cmpos-demo.herokuapp.com";

  Future<List<ProductResponse>> getStock() async {
    final url = '$_baseURL/product';

    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      return productResponseFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }
}
