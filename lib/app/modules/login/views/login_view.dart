import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/custom_widget/custom_widget_button.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/adaptive_text.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/theme.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget form() {
      return Obx(
        () => Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: controller.username,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Username',
                    ),
                    validator: (value) => controller.validateUsername(value),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: controller.password,
                    obscureText: controller.isObsecure.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // labelText: 'Password',
                      hintText: 'Masukkan Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObsecure.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          controller.isObsecure.toggle();
                        },
                      ),
                    ),
                    validator: (value) => controller.validatePassword(value),
                  ),
                ),
                const SizedBox(height: 20),
                CustomWidgetButton(
                  onPress: () {
                    controller.login();
                  },
                ),
                const SizedBox(height: 53),
                Text(
                  "Copyright © 2023 GMI Sola Gracia Tangerang",
                  style: whiteTextStyle.copyWith(
                    fontSize:
                        AdaptiveTextSize().getAdaptiveTextSize(context, 12),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      );
    }

    Widget backgroundImage() {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/bg-login.png",
          fit: BoxFit.cover,
        ),
      );
    }

    Widget headerContent() {
      return Column(
        children: [
          const SizedBox(height: 70),
          Image.asset(
            "assets/logo.png",
            width: 50,
          ),
          const SizedBox(height: 30),
          Text(
            "GMI SOLA GRACIA",
            style: whiteTextStyle.copyWith(
              fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 18),
              fontWeight: black,
            ),
          ),
          Text(
            "TANGERANG",
            style: whiteTextStyle.copyWith(
              fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 18),
              fontWeight: black,
            ),
          ),
          const SizedBox(height: 116),
          Text(
            "SELAMAT DATANG",
            style: whiteTextStyle.copyWith(
              fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 18),
              fontWeight: black,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Masuk Menggunakan Akun Anda",
            style: whiteTextStyle.copyWith(
              fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 14),
              fontWeight: light,
            ),
          ),
        ],
      );
    }

    Widget content() {
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerContent(),
              form(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      key: controller.scaffoldKey,
      body: Stack(
        children: [
          backgroundImage(),
          content(),
          // form(),
        ],
      ),
    );
  }
}
