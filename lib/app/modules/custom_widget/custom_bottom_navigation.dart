import 'package:flutter/material.dart';

import '../utils/adaptive_text.dart';
import '../utils/theme.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    required this.nameBar,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String nameBar;
  final String icon;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 31),
              decoration: BoxDecoration(
                color: isActive ? primaryColor.withOpacity(0.1) : whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                icon,
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              nameBar,
              style: isActive
                  ? primaryTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 10),
                      fontWeight: black,
                    )
                  : greyTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 10),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
