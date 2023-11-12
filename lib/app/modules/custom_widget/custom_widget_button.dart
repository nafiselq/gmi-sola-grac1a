import 'package:flutter/material.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/adaptive_text.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/theme.dart';

class CustomWidgetButton extends StatelessWidget {
  const CustomWidgetButton({
    super.key,
    this.width = double.infinity,
    this.text = 'Login',
    required this.onPress,
    this.isValid = true,
  });

  final double width;
  final String text;
  final Function() onPress;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: isValid ? primaryColor : greyColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton(
        onPressed: isValid ? onPress : null,
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 14),
            fontWeight: black,
          ),
        ),
      ),
    );
  }
}
