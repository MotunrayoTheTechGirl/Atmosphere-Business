// ignore_for_file: prefer_const_constructors

import 'package:dealer_portal_mobile/core/common_widgets/app_text_field.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;

import '../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../my_plans/data/controller/get_dealer_by_identity_controller.dart';
import '../onboarding/data/controller/user_details_controller.dart';

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
    final nameController =
        TextEditingController(text: userDetailsController?.name ?? '');
    final ninController = TextEditingController(
        text: userDetailsController?.identificationNumber ?? '');

    final phoneNumberController =
        TextEditingController(text: userDetailsController?.phoneNumber ?? '');
    final businessNameController = TextEditingController(
        text: dealerIdentityController?.businessName ?? '');
    final corperateAffairsCommisionCtrl =
        TextEditingController(text: dealerIdentityController?.cacNumber ?? '');
    final taxIdentificationNumberCtrl = TextEditingController(
        text: dealerIdentityController?.taxIdNumber ?? '');
    final businessEmailCtrl = TextEditingController(
        text: dealerIdentityController?.businessEmail ?? '');
    final businessAddressCtrl = TextEditingController(
        text: dealerIdentityController?.businessAddress ?? '');
    final businessCategoryCtrl = TextEditingController(
        text: dealerIdentityController?.businessCategory ?? '');
    final cacCertificateCtrl = TextEditingController(
        text: dealerIdentityController?.cacCertUrl.isEmpty ||
                dealerIdentityController?.cacCertUrl == null
            ? "Not Uploaded"
            : "Uploaded");
    final mmatCertificateCtrl = TextEditingController(
        text: dealerIdentityController?.mmatCertUrl.isEmpty ||
                dealerIdentityController?.mmatCertUrl == null
            ? "Not Uploaded"
            : "Uploaded");
    final scmulCertificateCtrl = TextEditingController(
        text: dealerIdentityController?.scumlCertUrl.isEmpty ||
                dealerIdentityController?.scumlCertUrl == null
            ? "Not Uploaded"
            : "Uploaded");
    final dynamic dateOfIncopertaion =
        dealerIdentityController?.dateOfIncorporation;
    final dateOfIncopertaionCtrl = TextEditingController(
        text: intl.DateFormat('dd/MM/yy')
            .format(DateTime.parse(dateOfIncopertaion)));
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Profile',
        suffixIcon: AppIcons.notification,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                          style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppTheme.montserratAlternate),
                        ),
                        4.hi,
                        Text(
                          'ID: $trimmedPhoneNumber',
                          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: AppTheme.montserratAlternate),
                        ),
                      ],
                    ),
                    10.wi,
                    SvgPicture.asset(AppIcons.editIcon),
                  ],
                ),
              ],
            ),
            40.hi,
            Text(
              'REPRESENTATIVE DETAILS',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textColor),
            ),
            20.hi,
            AppTextField(
              label: 'Representative Name',
              controller: nameController,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'National Identification Number',
              controller: ninController,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'Phone Number',
              controller: phoneNumberController,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            40.hi,
            Text(
              'BUSINESS DETAILS',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textColor),
            ),
            20.hi,
            AppTextField(
              label: 'Business Name',
              controller: businessNameController,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'Corporate Affairs Commission Number',
              controller: corperateAffairsCommisionCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'Tax Identification Number',
              controller: taxIdentificationNumberCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'Business Email Address',
              controller: businessEmailCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'Business Address',
              controller: businessAddressCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'Business Category',
              controller: businessCategoryCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'CAC Certificate',
              controller: cacCertificateCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'MMAT Certificate',
              controller: mmatCertificateCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'SCMUL Certificate',
              controller: scmulCertificateCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
            20.hi,
            AppTextField(
              label: 'Date of Incorporation ',
              controller: dateOfIncopertaionCtrl,
              hintText: '',
              filled: false,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightBorder),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ).padHorizontal(16)),
      ),
    );
  }
}
