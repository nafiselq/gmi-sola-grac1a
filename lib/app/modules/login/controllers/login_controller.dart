import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/form_models/form_login_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/auth_services.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/custom_snack_bar.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/fullscreen_dialog_loader.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/key_value.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Global Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //TextForm
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  //Services
  AuthServices authServices = AuthServices();

  //Variable
  RxBool isObsecure = true.obs;
  RxBool isFailedLogin = false.obs;
  GetStorage box = GetStorage();

  //Function login
  void login() async {
    //Chek Validator

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    //Proses Loading
    FullScreenDialogLoader.showDialog();

    //Manggil Service Login
    final response = await authServices.login(
        FormLoginModel(username: username.text, password: password.text));

    //Tampung response login menggunakan Dartz Left & Right, Jika L(Left) maka Gagal. Jika R(Right) maka success responsenya.
    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      CustomSnackBar.showErrorSnackBar(
          context: Get.context, title: "Ooops!", message: l.message.toString());
      return isFailedLogin.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isFailedLogin.value = false;
      box.write(KeyValue.keyToken, r.data?.token);
      box.write(KeyValue.keyIsLoggedIn, true);
      box.write(KeyValue.keyUser, r.data?.detailData?.username);
      return Get.offAllNamed(Routes.HOME);
    });
    //
  }

  //Validate Username
  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Username harus diisi";
    }
    if (value.length < 3) {
      return "Username harus lebih dari 3 karakter";
    }
    return null;
  }

  //Validate Password
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password harus diisi";
    }
    if (value.length < 3) {
      return "Password harus lebih dari 3 karakter";
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
