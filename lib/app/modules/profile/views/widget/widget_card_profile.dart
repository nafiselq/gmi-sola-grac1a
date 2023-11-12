import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/list_anggota_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/profile_model.dart';
import 'package:gmi_sola_gracia_apps/app/modules/detail_anggota/controllers/detail_anggota_controller.dart';
import 'package:gmi_sola_gracia_apps/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../../utils/adaptive_text.dart';
import '../../../utils/theme.dart';

class WidgetCardProfile extends StatelessWidget {
  const WidgetCardProfile({super.key, required this.dataProfile});

  final DataProfile dataProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
              dataProfile.biodataProfile?.photo == null
                  ? Image.asset(
                      "assets/ic-dummy-profile-anggota.png",
                      width: 50,
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: NetworkImage(
                            dataProfile.biodataProfile!.photo.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${dataProfile.biodataProfile?.name}",
                      style: blackTextStyle.copyWith(
                        fontSize:
                            AdaptiveTextSize().getAdaptiveTextSize(context, 18),
                        fontWeight: black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${dataProfile.username}",
                      style: blackTextStyle.copyWith(
                        fontSize:
                            AdaptiveTextSize().getAdaptiveTextSize(context, 14),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  final editProfileC = Get.put(EditProfileController());
                  editProfileC.dataProfile.value = dataProfile;
                  Get.toNamed(Routes.EDIT_PROFILE);
                },
                child: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
