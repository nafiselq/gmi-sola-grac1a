import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/form_models/form_presence_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/news_berita_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/now_ibadah_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/submit_presence_home_model.dart';
import '../../modules/utils/config_dio.dart';

class HomeServices {
  Dio dio = ApiServices().launch();
  ApiServices api = ApiServices();
  GetStorage box = GetStorage();

  Future<Either<NewsBeritaHomeResponse, NewsBeritaHomeResponse>>
      getDaftarBerita(String? limit, String? page) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/news?limit=$limit&page=$page",
      );

      // print("ini response dari api : ${response.data}");
      if (response.statusCode == 200) {
        return Right(NewsBeritaHomeResponse.fromJson(response.data));
      } else {
        return Left(NewsBeritaHomeResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjasi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(NewsBeritaHomeResponse.fromJson(json));
      // throw Exception("Error!");
    }
  }

  Future<Either<ErrorIbadahNow, NowIbadahHomeResponse>> getIbadahNow() async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/pray/now",
      );

      debugPrint("ini response : ${response.data}");

      if (response.statusCode == 200) {
        return Right(NowIbadahHomeResponse.fromJson(response.data));
      } else if (response.statusCode == 404) {
        return Left(ErrorIbadahNow.fromJson(response.data));
      } else {
        return Left(ErrorIbadahNow.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message': "$e",
      };
      debugPrint("ini error : $e");
      return Left(ErrorIbadahNow.fromJson(json));
      // throw Exception("Error!");
    }
  }

  Future<Either<ErrorSubmitPresence, SubmitPresenceHomeResponse>>
      submitPresence(FormPresenceModel data) async {
    try {
      final response = await dio.post(
        "${api.baseUrlMainApi}/presence",
        data: data.toJson(),
      );

      debugPrint("ini response : ${response.data}");

      if (response.statusCode == 200) {
        return Right(SubmitPresenceHomeResponse.fromJson(response.data));
      } else if (response.statusCode == 404) {
        return Left(ErrorSubmitPresence.fromJson(response.data));
      } else {
        return Left(ErrorSubmitPresence.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message': "$e",
      };
      debugPrint("ini error : $e");
      return Left(ErrorSubmitPresence.fromJson(json));
      // throw Exception("Error!");
    }
  }
}
