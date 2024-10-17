// ignore_for_file: prefer_const_constructors

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../my_plans/data/controller/get_dealer_by_identity_controller.dart';
import '../onboarding/data/controller/user_details_controller.dart';
import 'widgets/profile_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    final dealerIdentityController =
        ref.watch(fetchDealerByIdentityControllerProvider).data?.data;
    final phoneNumber = userDetailsController?.phoneNumber ?? '';
    final trimmedPhoneNumber = phoneNumber.substring(4);
    final dynamic dateOfIncopertaion =
        dealerIdentityController?.dateOfIncorporation;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Profile',
        suffixIcon: AppIcons.notification,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await ref
                .read(fetchDealerByIdentityControllerProvider.notifier)
                .dealerIdentity(
                    phoneNumber: ref
                            .watch(userDetailsControllerProvider.notifier)
                            .state
                            .data
                            ?.data
                            ?.user
                            ?.phoneNumber ??
                        "");
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppIcons.avatar,
                          fit: BoxFit.scaleDown,
                          height: 80.h,
                          width: 80.w,
                        ),
                        10.hi,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${userDetailsController?.name ?? ''}',
                                  style: AppTheme.lightTextTheme.displaySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppTheme.montserratAlternate),
                                ),
                                4.hi,
                                Text(
                                  'ID: $trimmedPhoneNumber',
                                  style: AppTheme.lightTextTheme.bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              AppTheme.montserratAlternate),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    40.hi,
                    Text(
                      'REPRESENTATIVE DETAILS',
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor),
                    ),
                    20.hi,
                    ProfileTile(
                      label: 'Representative Name',
                      data: userDetailsController?.name ?? 'Not Added',
                    ),
                    20.hi,
                    ProfileTile(
                        label: 'National Identification Number',
                        data: userDetailsController?.identificationNumber ??
                            'Not Added'),
                    20.hi,
                    ProfileTile(
                        label: 'Phone Number',
                        data:
                            userDetailsController?.phoneNumber ?? 'Not Added'),
                    30.hi,
                    Text(
                      'BUSINESS DETAILS',
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor),
                    ),
                    20.hi,
                    ProfileTile(
                        label: 'Business Name',
                        data: dealerIdentityController?.businessName ??
                            'Not Added'),
                    20.hi,
                    ProfileTile(
                        label: 'Corporate Affairs Commission Number',
                        data:
                            dealerIdentityController?.cacNumber ?? 'Not Added'),
                    20.hi,
                    ProfileTile(
                        label: 'Tax Identification Number',
                        data: dealerIdentityController?.taxIdNumber ??
                            'Not Added'),
                    20.hi,
                    ProfileTile(
                        label: 'Business Email Address',
                        data: dealerIdentityController?.businessEmail ??
                            'Not Added'),
                    20.hi,
                    ProfileTile(
                        label: 'Business Address',
                        data: dealerIdentityController?.businessAddress ??
                            'Not Added'),
                    20.hi,
                    ProfileTile(
                        label: 'Business Category',
                        data: dealerIdentityController?.businessCategory ??
                            'Not Added'),
                    20.hi,
                    ProfileTile(
                        label: 'CAC Certificate',
                        data: dealerIdentityController?.cacCertUrl == null
                            ? "Not Uploaded"
                            : "Uploaded"),
                    20.hi,
                    ProfileTile(
                        label: 'MMAT Certificate',
                        data: dealerIdentityController?.mmatCertUrl == null
                            ? "Not Uploaded"
                            : "Uploaded"),
                    20.hi,
                    ProfileTile(
                        label: 'SCMUL Certificate',
                        data: dealerIdentityController?.scumlCertUrl == null
                            ? "Not Uploaded"
                            : "Uploaded"),
                    20.hi,
                    ProfileTile(
                        label: 'Date of Incorporation ',
                        data: dateOfIncopertaion == null
                            ? "Not added"
                            : intl.DateFormat('dd/MM/yy').format(
                                DateTime.parse(dateOfIncopertaion ?? ''))),
                  ],
                ).padHorizontal(16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
