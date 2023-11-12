import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/list_anggota_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/list_history_presence_model.dart';
import 'package:gmi_sola_gracia_apps/app/modules/detail_anggota/controllers/detail_anggota_controller.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../../utils/adaptive_text.dart';
import '../../../utils/theme.dart';

class WidgetCardHistory extends StatelessWidget {
  const WidgetCardHistory({super.key, required this.presence});

  final ListHistoryPresence presence;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Image.asset(
              "assets/ic-dummy-profile-anggota.png",
              width: 50,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${presence.title}",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 18),
                      fontWeight: black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${presence.presence}",
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
    );
  }
}
