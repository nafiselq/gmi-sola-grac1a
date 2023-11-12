import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/global_helper.dart';

import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';
import '../controllers/detail_berita_controller.dart';

class DetailBeritaView extends GetView<DetailBeritaController> {
  const DetailBeritaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String htmlApi = '''
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        </head>
        <body>

        <div style="margin-left:-8px; font-size:${AdaptiveTextSize().getAdaptiveTextSize(context, 12)}px; overflow: hidden; text-overflow: ellipsis;">
          ${controller.detailBerita.value.content}
        </div>

        </body>
        </html>
        ''';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita',
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
        () => controller.isLoadingBerita.value
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    "${controller.detailBerita.value.title}",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 16),
                      fontWeight: black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  controller.isLoadingBerita.value
                      ? Text("Sedang memuat data...")
                      : Text(
                          "${GlobalHelper().formatDateFromJson("${controller.detailBerita.value.createdAt}")}",
                          style: greyTextStyle.copyWith(
                            fontSize: AdaptiveTextSize()
                                .getAdaptiveTextSize(context, 12),
                          ),
                        ),
                  const SizedBox(height: 10),
                  Image.network(
                    "${controller.detailBerita.value.thumbnail}",
                  ),
                  const SizedBox(height: 18),
                  HtmlWidget(htmlApi),
                  // Html(data: kLocalExamplePage),
                ],
              ),
      ),
    );
  }
}
