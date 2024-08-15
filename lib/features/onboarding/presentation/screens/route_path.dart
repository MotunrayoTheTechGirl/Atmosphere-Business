import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/features/app/presentation/screen/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_icons.dart';

class RoutePath extends StatefulWidget {
  const RoutePath({super.key});

  @override
  State<RoutePath> createState() => _RoutePathState();
}

class _RoutePathState extends State<RoutePath> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return App();
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 844.h,
      width: 390.w,
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: Center(
        child: SvgPicture.asset(AppIcons.appLogo),
      ),
    );
  }
}
