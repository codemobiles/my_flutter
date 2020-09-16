import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_flutter/src/services/header_interceptor.dart';

class NetworkService {
  static final Dio _dio = Dio()
    ..interceptors.addAll(
      [
        HeaderInterceptor(),
        LogInterceptor(),
      ],
    );

  static const _baseURL = "https://cmpos-demo.herokuapp.com";

  Future<List<dynamic>> getStock() async {
    final url = '$_baseURL/product';

    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      // return productFromJson(jsonEncode(response.data));
      return null;
    }
    throw Exception('Network failed');
  }
}
