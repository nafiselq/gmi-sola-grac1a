import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/detail_anggota_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/list_anggota_model.dart';

import '../../modules/utils/config_dio.dart';
import '../models/response_models/ibadah/list_ibadah_model.dart';

class AnggotaServices {
  Dio dio = ApiServices().launch();
  ApiServices api = ApiServices();
  GetStorage box = GetStorage();

  Future<Either<ListAnggotaResponse, ListAnggotaResponse>> getListAnggota(
      String? limit, int? page) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/member?limit=$limit&page=$page",
      );
      if (response.statusCode == 200) {
        return Right(ListAnggotaResponse.fromJson(response.data));
      } else {
        return Left(ListAnggotaResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(ListAnggotaResponse.fromJson(json));
    }
  }

  Future<Either<DetailAnggotaResponse, DetailAnggotaResponse>> getAnggotaById(
      int? date) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/member/$date",
      );
      if (response.statusCode == 200) {
        return Right(DetailAnggotaResponse.fromJson(response.data));
      } else {
        return Left(DetailAnggotaResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(DetailAnggotaResponse.fromJson(json));
    }
  }
}
