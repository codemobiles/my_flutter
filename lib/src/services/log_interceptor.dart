import 'package:dio/dio.dart';

class LogInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    print(options.baseUrl + options.path);
    return super.onRequest(options);
  }
}
