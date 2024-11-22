// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/enums.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/create_ads_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/upload_box_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../../../onboarding/data/controller/user_details_controller.dart';
import '../../../../subscriptions/data/controller/file_upload_controller.dart';
import '../../../data/controller/create_advert_controller.dart';
import '../../widgets/size_guide_text_button.dart';
import '../../widgets/textfield_with_inline_label.dart';

final adSizeStateProvider = StateProvider<String>((ref) => '');
// final imageStateProvider = StateProvider<String>((ref) => '');

final imagePickedStateProvider = StateProvider<File>((ref) => File(''));

class ImageAdTabBiew extends ConsumerStatefulWidget {
  const ImageAdTabBiew({
    super.key,
  });

  @override
  ConsumerState<ImageAdTabBiew> createState() => _ImageAdTabBiewState();
}

class _ImageAdTabBiewState extends ConsumerState<ImageAdTabBiew> {
  DateTime startDate = DateTime.now();
  FilePickerResult? result;
  bool isFormValid = false;

  final adTitleController = TextEditingController();
  final adDescriptionController = TextEditingController();
  final targetUrlController = TextEditingController();
  final bugetController = TextEditingController();
  final durationController = TextEditingController();
  final startDateController = TextEditingController();
  final deviceTypeController = TextEditingController();
  final desiredScreenController = TextEditingController();
  final callToActionController = TextEditingController();
  final businessCategoryController = TextEditingController();
  //? optional
  final regionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startDateController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    startDateController.dispose();
    super.dispose();
  }

  bool valiadteForm() {
    if (adTitleController.text.isNotEmpty &&
        adDescriptionController.text.isNotEmpty &&
        targetUrlController.text.isNotEmpty &&
        bugetController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        deviceTypeController.text.isNotEmpty &&
        desiredScreenController.text.isNotEmpty &&
        callToActionController.text.isNotEmpty &&
        businessCategoryController.text.isNotEmpty &&
        result != null) {
      return isFormValid = true;
    }
    return false;
  }

  TextEditingController displaySize(
      TextEditingController textEditingController) {
    if (textEditingController.text.isEmpty) {
      return TextEditingController();
    } else if (textEditingController.text == 'Mobile') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(adSizeStateProvider.notifier).state = '298 x 142';
      });
      return TextEditingController(text: '298 x 142');
    } else if (textEditingController.text == 'Desktop') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(adSizeStateProvider.notifier).state = '741 x 170';
      });
      return TextEditingController(text: '741 x 170');
    }
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;

    return SizedBox(
      height: .9.sh,
      child: ListView(
        shrinkWrap: true,
        // physics: const BouncingScrollPhysics(),
        children: [
          Text(
            'Ad Information',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.black,
            ),
          ),
          TextfieldWithInlineLabel(
            controller: adTitleController,
            label: 'Ad Title',
          ),
          15.hi,
          TextfieldWithInlineLabel(
            controller: adDescriptionController,
            label: 'Ad Description',
            maxLines: 4,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
          ),
          15.hi,
          TextfieldWithInlineLabel(
            controller: targetUrlController,
            label: 'Target URL',
            hintText: 'e.g www.atem...',
            suffixIcon: SvgPicture.asset(
              AppIcons.info,
              color: AppColors.greyShade300,
              fit: BoxFit.scaleDown,
              width: 14.w,
              height: 14.h,
            ),
          ),
          15.hi,
          TextfieldWithInlineLabel(
            controller: bugetController,
            hintText: 'e.g 50,000',
            label: 'Budget',
            suffixIcon: SvgPicture.asset(
              AppIcons.info,
              color: AppColors.greyShade300,
              fit: BoxFit.scaleDown,
              width: 14.w,
              height: 14.h,
            ),
            keyboardType: TextInputType.number,
          ),
          15.hi,
          Row(
            children: [
              Expanded(
                child: TextfieldWithInlineLabel(
                  readOnly: true,
                  controller: startDateController,
                  hintText: startDateController.text.isNotEmpty
                      ? DateFormat('yyyy-MM-dd').format(startDate)
                      : 'select start date',
                  label: 'Start Date',
                  suffixIcon: SvgPicture.asset(
                    AppIcons.calendar,
                    fit: BoxFit.scaleDown,
                  ),
                  onTap: () async {
                    final currentDate = DateTime.now();
                    final datePicker = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: DateTime(currentDate.year - 0),
                        lastDate: DateTime(currentDate.year + 100));
                    if (datePicker != null) {
                      startDate = datePicker;
                      startDateController.text =
                          DateFormat('yyyy-MM-dd').format(startDate);
                    }
                  },
                ),
              ),
              16.wi,
              Expanded(
                child: TextfieldWithInlineLabel(
                  controller: durationController,
                  hintText: 'e.g 10 Days',
                  label: 'Duration (Days)',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          8.hi,
          TextfieldWithInlineLabel(
            controller: deviceTypeController,
            label: 'Device Type',
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 580.h, 0, 580.w),
                color: AppColors.white,
                items: [
                  'Mobile',
                  'Desktop',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                deviceTypeController.text = selected;
                setState(() {});
              }
            },
          ),
          8.hi,
          TextfieldWithInlineLabel(
            readOnly: true,
            controller: displaySize(deviceTypeController),
            label: 'Size',
          ),
          8.hi,
          TextfieldWithInlineLabel(
            readOnly: true,
            controller: desiredScreenController,
            label: 'Desired Screen',
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 450.h, 0, 460.w),
                color: AppColors.white,
                items: [
                  'Welcome page',
                  'Home page',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                desiredScreenController.text = selected;
                setState(() {});
              }
            },
          ),
          8.hi,
          TextfieldWithInlineLabel(
            controller: callToActionController,
            label: 'Call to Action Text',
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 450.h, 0, 460.w),
                color: AppColors.white,
                items: [
                  'Learn more',
                  'click me',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                callToActionController.text = selected;
                setState(() {});
              }
            },
          ),
          8.hi,
          TextfieldWithInlineLabel(
            controller: businessCategoryController,
            label: 'Business Category',
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 450.h, 0, 760.w),
                color: AppColors.white,
                items: [
                  'Manufacturing',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                businessCategoryController.text = selected;
                setState(() {});
              }
            },
          ),
          24.hi,
          Text(
            'Target Location',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.black,
            ),
          ),
          8.hi,
          TextfieldWithInlineLabel(
            controller: regionController,
            label: 'Region',
            isRequired: false,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            readOnly: true,
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 750.h, 0, 60.w),
                color: AppColors.white,
                items: [
                  'Lagos',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                regionController.text = selected;
                setState(() {});
              }
            },
          ),
          12.hi,
          RichText(
            text: TextSpan(
              text: 'Upload Image',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.deepAsh,
              ),
              children: [
                TextSpan(
                  text: ' * ',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ),
          14.hi,
          InkWell(
              onTap: () async {
                final pickedResult = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.image,
                );
                if (pickedResult == null) {
                  log("No file selected");
                } else {
                  setState(() {});
                  for (var element in pickedResult.files) {
                    log('Selected File: ${element.name}');
                    log('Selected File size: ${result?.files.first.extension ?? ''} | ${(pickedResult.files.first.size ?? 0) / 1024}MB');
                  }
                  if (pickedResult.files.isNotEmpty) {
                    final file = pickedResult.files.first;
                    final fileSize = file.size;
                    if (fileSize < 1024 || fileSize > 1024 * 1024 * 5) {
                      setState(() {
                        result = null;
                      });
                      log('image size above limit');
                      CustomSnackBar.showSnackBar(
                        context: context,
                        message: 'Image size must be between 1 KB and 5 MB',
                      );
                    } else {
                      setState(() {
                        result = pickedResult;
                        final resultFile =
                            File(pickedResult.files.first.path ?? '');
                        ref.read(imagePickedStateProvider.notifier).state =
                            resultFile;

                        log('final result = $result');
                      });
                      log('Selected File: ${file.name}');
                    }
                  }
                }
              },
              child: DottedBorder(
                color: AppColors.w5Color,
                strokeWidth: 1.5,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: Radius.circular(14.r),
                child: Container(
                  padding: const EdgeInsets.all(36),
                  child: Center(
                    child: result != null
                        ? Text(' ${(result?.files.first.name)}')
                        : const UploadBoxText(),
                  ),
                ),
              )),
          21.hi,
          SizeGuideTextButton(
            onTap: () {},
          ),
          40.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppElevatedButton(
                  onTap: () {},
                  bgColor: AppColors.lightPurple,
                  label: 'Save Progress',
                  labelStyle: AppTheme.lightTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.w5Color, fontSize: 16.sp),
                ),
              ),
              60.wi,
              Expanded(
                child: AppElevatedButton(
                  isActive: valiadteForm(),
                  isLoading:
                      ref.watch(receiptFileUploadControllerProvider).status ==
                              ResponseStatus.loading ||
                          ref.watch(createAdvertControllerProvider).status ==
                              ResponseStatus.loading,
                  onTap: valiadteForm()
                      ? () async {
                          //! upload image endpoint
                          final hasUploadedImage = await ref
                              .read(
                                  receiptFileUploadControllerProvider.notifier)
                              .uploadFile(
                                file: ref.watch(imagePickedStateProvider),
                              );
                          if (hasUploadedImage) {
                            final data = ref
                                .read(receiptFileUploadControllerProvider)
                                .data;
                            final trimmedData =
                                data?.substring(data.indexOf('/dealer'));
                            log('trimmed Data: $trimmedData');

                            //! create  image adverts
                            final hasCreatedImageAds = await ref
                                .read(createAdvertControllerProvider.notifier)
                                .createAds(
                                    advertiserId: int.parse(
                                        ref.watch(advertiserIdStateProvider)),
                                    title: adTitleController.text,
                                    description: adDescriptionController.text,
                                    adType: 'image',
                                    adSize: ref.watch(adSizeStateProvider),
                                    mediaUrl:
                                        'https://api-dev.wave5wireless.ng/content$trimmedData}',
                                    targetUrl: targetUrlController.text,
                                    budget: int.parse(bugetController.text),
                                    duration:
                                        int.parse(durationController.text),
                                    startDate: startDateController.text,
                                    businessCategory:
                                        businessCategoryController.text,
                                    deviceType: deviceTypeController.text,
                                    callToActionText:
                                        callToActionController.text,
                                    desiredScreen: desiredScreenController.text,
                                    regionIds: []);
                            if (hasCreatedImageAds) {
                              CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: 'Image Advert created SuccessFully');
                              adTitleController.clear();
                              adDescriptionController.clear();
                              targetUrlController.clear();
                              bugetController.clear();
                              startDateController.clear();
                              durationController.clear();
                              deviceTypeController.clear();
                              desiredScreenController.clear();
                              callToActionController.clear();
                              businessCategoryController.clear();
                              result = null;
                            } else {
                              CustomSnackBar.showSnackBar(
                                context: context,
                                isError: true,
                                message: ref
                                        .read(createAdvertControllerProvider
                                            .notifier)
                                        .state
                                        .message ??
                                    '',
                              );
                            }
                          } else {
                            CustomSnackBar.showSnackBar(
                              context: context,
                              isError: true,
                              message:
                                  'Oops! Image size must be between 1 KB and 5 MB '
                                  '',
                            );
                            log('Error during upload process');
                          }
                        }
                      : () {},
                  label: 'Submit',
                ),
              ),
            ],
          ),
          100.hi,
        ],
      ),
    );
  }
}
