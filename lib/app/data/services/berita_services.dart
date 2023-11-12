import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/berita/detail_berita_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/berita/list_berita_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/news_berita_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/now_ibadah_home_model.dart';
import '../../modules/utils/config_dio.dart';

class BeritaServices {
  Dio dio = ApiServices().launch();
  ApiServices api = ApiServices();
  GetStorage box = GetStorage();

  Future<Either<ListBeritaResponse, ListBeritaResponse>> getDaftarBerita(
      String? limit, int? page) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/news?limit=$limit&page=$page",
      );
      if (response.statusCode == 200) {
        return Right(ListBeritaResponse.fromJson(response.data));
      } else {
        return Left(ListBeritaResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(ListBeritaResponse.fromJson(json));
    }
  }

  Future<Either<DetailBeritaResponse, DetailBeritaResponse>> getBeritabyId(
      int? beritaId) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/news/$beritaId",
      );
      if (response.statusCode == 200) {
        return Right(DetailBeritaResponse.fromJson(response.data));
      } else {
        return Left(DetailBeritaResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(DetailBeritaResponse.fromJson(json));
    }
  }
}
