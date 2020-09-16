import 'package:dio/dio.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    // final headers = {
    //   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMTUwIiwibmFtZSI6IlRhbmFrb3JuIiwiaWF0IjoxNTE2MjM5MDIyfQ.MIIjQP3T4GVAuSGpsNG4wnLRdsrEehlS_Ld_8EEFlLk",
    // };

    SharedPreferences pref = await SharedPreferences.getInstance();
    final headers = {
        "token" : pref.get(Constants.PREF_TOKEN) ?? ""
    };

    options.headers.addAll(headers);
    return super.onRequest(options);
  }
}