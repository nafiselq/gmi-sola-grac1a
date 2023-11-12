import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/berita/list_berita_model.dart';
import 'package:gmi_sola_gracia_apps/app/modules/detail_berita/controllers/detail_berita_controller.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/global_helper.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../../utils/adaptive_text.dart';
import '../../../utils/theme.dart';

class CardBeritaBerita extends StatelessWidget {
  const CardBeritaBerita({super.key, required this.listDataBerita});

  final ListDataBerita listDataBerita;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final detailBerita = Get.put(DetailBeritaController());
        detailBerita.getDetailBerita(listDataBerita.id);
        Get.toNamed(Routes.DETAIL_BERITA);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "${listDataBerita.thumbnail}",
                width: 160,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${listDataBerita.title}",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 16),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    "${GlobalHelper().formatDateFromJson("${listDataBerita.createdAt}")}",
                    style: greyTextStyle.copyWith(
                      fontSize: AdaptiveTextSize().getAdaptiveTextSize(
                        context,
                        12,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
