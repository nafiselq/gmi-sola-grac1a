import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';
import '../controllers/detail_anggota_controller.dart';

class DetailAnggotaView extends GetView<DetailAnggotaController> {
  const DetailAnggotaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Anggota',
          style: blackTextStyle.copyWith(
            fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 15),
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: blackColor,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
        children: [
          Text(
            "Data Pribadi",
            style: blackTextStyle.copyWith(
              fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 16),
              fontWeight: black,
            ),
          ),
          const SizedBox(height: 17),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: controller.listAnggotaDetail.length,
              itemBuilder: (context, index) {
                var data = controller.listAnggotaDetail[index];

                if (controller.isLoadingAnggotaDetail.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.isFailedLoadAnggotaDetail.value) {
                  return const Center(
                    child: Text(
                        "Ooops, Terjadi Kesalahan, silahkan coba lagi nnti"),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.title}",
                        style: greyTextStyle.copyWith(fontWeight: black),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${data.value}",
                        style: greyTextStyle,
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
