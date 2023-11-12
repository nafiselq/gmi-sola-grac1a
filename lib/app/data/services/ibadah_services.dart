import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/berita/detail_berita_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/berita/list_berita_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/news_berita_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/now_ibadah_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/ibadah/detail_ibadah_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/ibadah/list_ibadah_model.dart';
import '../../modules/utils/config_dio.dart';

class IbadahServices {
  Dio dio = ApiServices().launch();
  ApiServices api = ApiServices();
  GetStorage box = GetStorage();

  Future<Either<ListIbadahResponse, ListIbadahResponse>> getDaftarIbadah(
      String? limit, int? page) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/pray?limit=$limit&page=$page",
      );
      if (response.statusCode == 200) {
        return Right(ListIbadahResponse.fromJson(response.data));
      } else {
        return Left(ListIbadahResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(ListIbadahResponse.fromJson(json));
    }
  }

  Future<Either<DetailIbadahResponse, DetailIbadahResponse>> getIbadahById(
      String? date) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/pray/$date",
      );
      if (response.statusCode == 200) {
        return Right(DetailIbadahResponse.fromJson(response.data));
      } else {
        return Left(DetailIbadahResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(DetailIbadahResponse.fromJson(json));
    }
  }
}
