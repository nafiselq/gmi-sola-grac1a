import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/list_anggota_model.dart';
import 'package:gmi_sola_gracia_apps/app/modules/detail_anggota/controllers/detail_anggota_controller.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../../utils/adaptive_text.dart';
import '../../../utils/theme.dart';

class WidgetCardAnggota extends StatelessWidget {
  const WidgetCardAnggota({super.key, required this.anggota});

  final ListDataAnggota anggota;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final detailAnggotaC = Get.put(DetailAnggotaController());
        detailAnggotaC.getAnggotaDetail(anggota.id!);
        Get.toNamed(Routes.DETAIL_ANGGOTA);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 24),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    // color: greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                        "${anggota.photo}",
                      ),
                    ),
                  )),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${anggota.name}",
                      style: blackTextStyle.copyWith(
                        fontSize:
                            AdaptiveTextSize().getAdaptiveTextSize(context, 18),
                        fontWeight: black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${anggota.name}",
                      style: blackTextStyle.copyWith(
                        fontSize:
                            AdaptiveTextSize().getAdaptiveTextSize(context, 14),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
