import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/key_value.dart';

import '../../routes/app_pages.dart';

class TokenInterceptors extends Interceptor {
  final box = GetStorage();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var token = box.read(KeyValue.keyToken);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final box = GetStorage();
      // final pageIndexController = Get.find();
      // pageIndexController.pageIndex.value = 0;
      box.erase();
      box.write(KeyValue.keyIsLoggedIn, false);
      Get.offAllNamed(Routes.LOGIN);
    }

    super.onError(err, handler);
  }
}
