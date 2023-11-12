import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/detail_ibadah/views/widget/widget_card_ibadah_detail.dart';

import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';
import '../controllers/detail_ibadah_controller.dart';

class DetailIbadahView extends GetView<DetailIbadahController> {
  const DetailIbadahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.titleHeader,
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
      body: Obx(
        () => controller.isLoadingIbadahDetail.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 23),
                children: [
                  Text(
                    "Detail Jadwal Ibadah",
                    style: blackTextStyle.copyWith(
                      fontSize: AdaptiveTextSize().getAdaptiveTextSize(
                        context,
                        16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.listIbadahDetail.length,
                    itemBuilder: (context, index) {
                      var data = controller.listIbadahDetail[index];
                      if (controller.isLoadingIbadahDetail.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (controller.isFailedLoadIbadahDetail.value) {
                        return Center(
                          child: Text(
                            "Ooops, Belum ada Detail Jadwal Ibadah",
                            style: blackTextStyle,
                          ),
                        );
                      } else {
                        return WidgetCardIbadahDetail(
                            ibadah: data, sesi: index++);
                      }
                    },
                  ),
                  // for (var item in controller.listIbadahDetail)
                  //   WidgetCardIbadahDetail(ibadah: item)
                ],
              ),
      ),
    );
  }
}
