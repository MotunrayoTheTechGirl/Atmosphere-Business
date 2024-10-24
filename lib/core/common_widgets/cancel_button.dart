import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.lighterText.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(14.4),
            ),
          ),
          child: SvgPicture.asset(
            AppIcons.cancel,
            width: 12,
            height: 12,
          ),
        ));
  }
}
