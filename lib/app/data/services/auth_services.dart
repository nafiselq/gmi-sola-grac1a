import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/form_models/form_login_model.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/config_dio.dart';

import '../models/response_models/auth/response_login_model.dart';

class AuthServices {
  Dio dio = ApiServices().launch();
  ApiServices api = ApiServices();
  GetStorage box = GetStorage();
  // Service login with email and password
  Future<Either<LoginResponse, LoginResponse>> login(
      FormLoginModel loginFormModel) async {
    try {
      final response = await dio.post(
        "${api.baseUrlMainApi}/login",
        data: loginFormModel.toJson(),
      );

      // print("ini response dari api : ${response.data}");
      if (response.statusCode == 200) {
        return Right(LoginResponse.fromJson(response.data));
      } else {
        return Left(LoginResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'status': "error",
        "data": null,
      };
      return Left(LoginResponse.fromJson(json));
      // throw Exception("Error!");
    }
  }
}
