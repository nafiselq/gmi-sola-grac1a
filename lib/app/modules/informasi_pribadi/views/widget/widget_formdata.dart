import 'package:flutter/material.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/global_helper.dart';
import 'package:intl/intl.dart';

import '../../../utils/adaptive_text.dart';
import '../../../utils/theme.dart';

class WidgetFormData extends StatelessWidget {
  WidgetFormData(
      {super.key,
      required this.label,
      this.controller,
      this.isAnak = false,
      this.isServiceHistory = false,
      this.isCalender = false,
      this.indexAnak,
      this.indexServiceHistory,
      this.onPressRemove,
      this.selectedDate,
      this.onValidator,
      this.keyboardType});

  final String label;
  final TextEditingController? controller;
  final bool isAnak;
  final bool isServiceHistory;
  final bool isCalender;
  final int? indexServiceHistory;
  final int? indexAnak;
  final Function()? onPressRemove;
  late DateTime? selectedDate;
  final String? Function(String?)? onValidator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 17),
        Text(
          label,
          style: blackTextStyle.copyWith(
            fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 12),
          ),
        ),
        isAnak && indexAnak! >= 0
            ? Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 14),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: greyColor.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        keyboardType: keyboardType,
                        validator: onValidator,
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: label,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: onPressRemove,
                    child: Icon(
                      Icons.delete,
                      color: primaryColor,
                    ),
                  ),
                ],
              )
            : isServiceHistory
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 14),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: greyColor.withOpacity(0.2),
                          ),
                          child: isCalender
                              ? TextFormField(
                                  keyboardType: keyboardType,
                                  controller: controller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: label,
                                  ),
                                  validator: onValidator,
                                  onTap: () async {
                                    selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1500),
                                      lastDate: DateTime(2101),
                                    );

                                    if (selectedDate != null) {
                                      // Format tanggal sesuai dengan yang Anda inginkan
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate!);
                                      // String formattedDate = DateFormat('yyyy-MM-dd')
                                      //     .format(selectedDate!);

                                      // Set nilai ke dalam controller
                                      controller?.text = GlobalHelper()
                                          .formatDateFromJson(formattedDate);
                                    }
                                  },
                                )
                              : TextFormField(
                                  keyboardType: keyboardType,
                                  validator: onValidator,
                                  controller: controller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: label,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: greyColor.withOpacity(0.2),
                    ),
                    child: isCalender
                        ? TextFormField(
                            keyboardType: keyboardType,
                            validator: onValidator,
                            controller: controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: label,
                            ),
                            onTap: () async {
                              selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1500),
                                lastDate: DateTime(2101),
                              );

                              if (selectedDate != null) {
                                // Format tanggal sesuai dengan yang Anda inginkan
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate!);
                                // String formattedDate = DateFormat('yyyy-MM-dd')
                                //     .format(selectedDate!);

                                // Set nilai ke dalam controller
                                controller?.text = GlobalHelper()
                                    .formatDateFromJson(formattedDate);
                              }
                            },
                          )
                        : TextFormField(
                            keyboardType: keyboardType,
                            validator: onValidator,
                            controller: controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: label,
                            ),
                          ),
                  ),
        isServiceHistory && indexServiceHistory == 3
            ? Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      "*) Klik Icon Sampah Untuk Hapus Riwayat Pelayanan",
                      style: primaryTextStyle.copyWith(
                        fontSize:
                            AdaptiveTextSize().getAdaptiveTextSize(context, 10),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onPressRemove,
                      child: Icon(
                        Icons.delete,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
