import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/ibadah/detail_ibadah_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/ibadah/list_ibadah_model.dart';
import 'package:gmi_sola_gracia_apps/app/modules/detail_ibadah/controllers/detail_ibadah_controller.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../../../utils/adaptive_text.dart';
import '../../../utils/theme.dart';

class WidgetCardIbadahDetail extends StatelessWidget {
  const WidgetCardIbadahDetail(
      {super.key, required this.ibadah, required this.sesi});

  final ListDataIbadaDetail ibadah;
  final int sesi;

  @override
  Widget build(BuildContext context) {
    final originalDate = DateTime.parse(ibadah.date.toString());
    final day = DateFormat('d').format(originalDate);
    final month = DateFormat('MMM').format(originalDate);
    return GestureDetector(
      onTap: () {
        final controller = Get.find<DetailIbadahController>();
        controller.show(context, ibadah);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 9),
        margin: const EdgeInsets.only(bottom: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: const LinearGradient(
            colors: [
              Color(0xffD3D0CF),
              Color(0xffffffff),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: whiteColor,
              ),
              child: Column(
                children: [
                  Text(
                    day,
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 20),
                      fontWeight: black,
                    ),
                  ),
                  Text(
                    month,
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${ibadah.title}",
                  style: blackTextStyle.copyWith(
                    fontSize:
                        AdaptiveTextSize().getAdaptiveTextSize(context, 16),
                    fontWeight: black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Sesi ${sesi + 1} | ${ibadah.startAt} - ${ibadah.endAt}",
                  style: blackTextStyle.copyWith(
                    fontSize:
                        AdaptiveTextSize().getAdaptiveTextSize(context, 12),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
