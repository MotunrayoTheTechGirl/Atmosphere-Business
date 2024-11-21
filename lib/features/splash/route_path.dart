// ignore_for_file: use_build_context_synchronously

import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/app_constants.dart';
import '../../core/storage/storage_service.dart';
import '../../core/utils/app_colors.dart';
import '../home/presentation/screens/home_screen.dart';
import '../onboarding/presentation/screens/welcome_screen.dart';

class RoutePath extends StatefulWidget {
  const RoutePath({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<RoutePath> {
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      final token = await secureStorageService.read(key: AppConstants.token);
      if (token == null) {
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const WelcomeScreen();
            },
          ),
        );
      } else {
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
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
      height: 1043.h,
      width: 390.w,
      decoration: const BoxDecoration(color: AppColors.white),
      child: Image.asset(
        AppIcons.appLogo,
        fit: BoxFit.scaleDown,
        height: 64.h,
        color: AppColors.w5Color,
      ),
    );
  }
}
