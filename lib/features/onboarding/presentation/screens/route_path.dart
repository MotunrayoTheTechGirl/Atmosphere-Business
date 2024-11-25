// ignore_for_file: use_build_context_synchronously

import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:dealer_portal_mobile/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../core/utils/app_icons.dart';

class RoutePath extends StatefulWidget {
  const RoutePath({super.key});

  @override
  State<RoutePath> createState() => _RoutePathState();
}

class _RoutePathState extends State<RoutePath> {
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      final token = await secureStorageService.read(key: AppConstants.token);
      if (token != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const WelcomeScreen();
            },
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 844.h,
      width: 390.w,
      decoration: const BoxDecoration(color: AppColors.red),
      child: Center(
        child: SvgPicture.asset(
          // AppIcons.appLogo,
          AppIcons.marketPlace,
          width: 20.w,
          height: 20.h,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
