import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/detail_anggota_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/list_anggota_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/list_history_presence_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/profile_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/update_account_model.dart';

import '../../modules/utils/config_dio.dart';
import '../models/response_models/ibadah/list_ibadah_model.dart';

class ProfileServices {
  Dio dio = ApiServices().launch();
  ApiServices api = ApiServices();
  GetStorage box = GetStorage();

  Future<Either<ProfileResponse, ProfileResponse>> getProfile() async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/profile",
      );
      if (response.statusCode == 200) {
        return Right(ProfileResponse.fromJson(response.data));
      } else {
        return Left(ProfileResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(ProfileResponse.fromJson(json));
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

  Future<Either<UpdateAccountResponse, UpdateAccountResponse>> updateAccount(
      FormData data) async {
    try {
      final response =
          await dio.post("${api.baseUrlMainApi}/profile/account", data: data);

      if (response.statusCode == 200) {
        return Right(UpdateAccountResponse.fromJson(response.data));
      } else {
        return Left(UpdateAccountResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(UpdateAccountResponse.fromJson(json));
    }
  }

  Future<Either<ListHistoryPresenceResponse, ListHistoryPresenceResponse>>
      getListHistoryPresence(String? limit, int? page) async {
    try {
      final response = await dio.get(
        "${api.baseUrlMainApi}/presence?limit=$limit&page=$page",
      );
      if (response.statusCode == 200) {
        return Right(ListHistoryPresenceResponse.fromJson(response.data));
      } else {
        return Left(ListHistoryPresenceResponse.fromJson(response.data));
      }
    } catch (e) {
      var json = {
        'status_code': 500,
        'message':
            "Terjadi kesalahan pada server internal kami, Silahkan coba lagi nanti.",
        "data": null,
      };
      return Left(ListHistoryPresenceResponse.fromJson(json));
    }
  }
}
