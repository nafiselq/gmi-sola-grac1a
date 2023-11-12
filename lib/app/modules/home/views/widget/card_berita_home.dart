import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/news_berita_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../../detail_berita/controllers/detail_berita_controller.dart';
import '../../../utils/adaptive_text.dart';
import '../../../utils/global_helper.dart';
import '../../../utils/theme.dart';

class CardBeritaHome extends StatelessWidget {
  const CardBeritaHome({super.key, required this.dataBerita});

  final DataBerita? dataBerita;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final detailBerita = Get.put(DetailBeritaController());
        detailBerita.getDetailBerita(dataBerita?.id);
        Get.toNamed(Routes.DETAIL_BERITA);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Image.network(
              "${dataBerita?.thumbnail}",
              width: 160,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${dataBerita?.title}",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${GlobalHelper().formatDateFromJson(dataBerita!.createdAt.toString())}",
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
