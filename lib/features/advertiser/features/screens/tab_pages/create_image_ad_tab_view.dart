// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/enums.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/ads_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/advertiser_overview_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/create_ads_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/draft_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/overview_tabview.dart';
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
import '../../../data/controller/update_ads_controller.dart';
import '../../../data/repository/get_adverts_repository.dart';
import '../../../data/repository/region_repository.dart';
import '../../widgets/size_guide_text_button.dart';
import '../../widgets/textfield_with_inline_label.dart';

final adSizeStateProvider = StateProvider<String?>((ref) => null);
final imageAdRegionIdStateProvider = StateProvider<String?>((ref) => null);
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

  late final TextEditingController adTitleController;
  late final TextEditingController adDescriptionController;
  late final TextEditingController targetUrlController;
  late final TextEditingController bugetController;
  late final TextEditingController durationController;
  late final TextEditingController startDateController;
  late final TextEditingController deviceTypeController;
  late final TextEditingController desiredScreenController;
  late final TextEditingController callToActionController;
  late final TextEditingController businessCategoryController;

  //? optional
  final lgaController = TextEditingController();
  final regionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    adTitleController = TextEditingController();
    adDescriptionController = TextEditingController();
    targetUrlController = TextEditingController();
    bugetController = TextEditingController();
    durationController = TextEditingController();
    startDateController = TextEditingController();
    deviceTypeController = TextEditingController();
    desiredScreenController = TextEditingController();
    callToActionController = TextEditingController();
    businessCategoryController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      adTitleController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyTitleStateProvider)
          : '';
      adDescriptionController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyDescriptionStateProvider)
          : '';
      targetUrlController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyTargetStateProvider)
          : '';
      bugetController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyBudgetStateProvider)
          : '';
      durationController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyDurationStateProvider)
          : '';
      startDateController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyStartDateStateProvider).split(' ')[0]
          : '';
      deviceTypeController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyDeviceStateProvider)
          : '';
      desiredScreenController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifydesiredScreenStateProvider)
          : '';
      callToActionController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyCallToActionStateProvider)
          : '';
      businessCategoryController.text = ref.watch(typeStateProvider) == 'image'
          ? ref.watch(modifyBusinessCategoryStateProvider)
          : '';

      log('media state: ${ref.watch(modifyDisplayContentStateProvider)}');

      if (mounted) setState(() {});
    });

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

  bool isDraftClicked = false;
  @override
  Widget build(BuildContext context) {
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    final regionFutureController = ref.watch(adsRegionRepositoryFutureProvider);
    return SizedBox(
      height: .9.sh,
      child: ListView(
        shrinkWrap: true,
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
            maxLines: 1,
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
            maxLines: 1,
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
            maxLines: 1,
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
                  hintText: 'e.g 20 Days',
                  label: 'Duration (Days)',
                  keyboardType: TextInputType.number,
                  maxLines: 1,
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
                  'Welcome Screen',
                  'SignUp/ Login Screen',
                  'Dashboard Screen',
                  'All Screen'
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
                  'Sign up',
                  'Learn more',
                  'Buy',
                  'Get Started',
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
                  'Agriculture',
                  'Art and Entertainment',
                  'Automative, Aircraft & boat',
                  'Beauty,Cosmetics & personal care',
                  'Commercial & Industrial'
                      'Education',
                  'Finance',
                  'Food & Beverage',
                  'Hotel & Lodging',
                  'Legal',
                  'Local Service',
                  'Media/News Company',
                  'Medical and Health',
                  'Non-Government Organization',
                  'Non profit organization',
                  'Public and government service',
                  'Real Estate',
                  'Science,Technology and Engineering',
                  'Shopping and retail',
                  'Sports and Retail',
                  'Travel and Transportation',
                  'other',
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
              final selected = await showMenu<Map<String, dynamic>>(
                context: context,
                position: RelativeRect.fromLTRB(30, 750.h, 0, 60.w),
                color: AppColors.white,
                items: regionFutureController.when(
                  data: (data) {
                    final uniqueRegions = data.data
                        .map((region) => {
                              'area': region.area,
                              'id': region.id,
                            })
                        .toSet()
                        .map((lgaInfo) => PopupMenuItem<Map<String, dynamic>>(
                              value: lgaInfo,
                              child: SizedBox(
                                child: Text(
                                  lgaInfo['area'] as String,
                                ),
                              ),
                            ))
                        .toList();
                    return uniqueRegions;
                  },
                  error: (error, stackTrace) => [],
                  loading: () => [],
                ),
              );

              if (selected != null) {
                log('selected region: ${selected['area']}');
                log('selected region id: ${selected['id']}');
                ref.read(imageAdRegionIdStateProvider.notifier).state =
                    selected['id'].toString();
                log('region Id state Provider: ${ref.watch(imageAdRegionIdStateProvider)}');
                setState(() {
                  regionController.text = selected['area'];
                });
                log('region ctrl : ${regionController.text}');
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
                      ref
                          .read(modifyDisplayContentStateProvider.notifier)
                          .state = result?.files.first.name ?? '';
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
                      child: ref.watch(isModifyStateProvider) == true &&
                              ref.watch(typeStateProvider) == 'image'
                          ? Text(ref
                              .watch(modifyDisplayContentStateProvider)
                              .substring(ref
                                      .watch(modifyDisplayContentStateProvider)
                                      .lastIndexOf('/') +
                                  1))
                          : result != null
                              ? Text(' ${result?.files.first.name}')
                              : const UploadBoxText()
                      //  result != null
                      //     ? Text(' ${(result?.files.first.name)}')
                      //     : const UploadBoxText(),
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
                  label: 'Save Progress',
                  isLoading: isDraftClicked == true
                      ? ref.watch(createAdvertControllerProvider).status ==
                              ResponseStatus.loading ||
                          ref
                                  .watch(receiptFileUploadControllerProvider)
                                  .status ==
                              ResponseStatus.loading
                      : false,
                  onTap: () async {
                    setState(() {
                      isDraftClicked = true;
                    });
                    //! integration for drafts
                    log('start date: ${startDateController.text.isEmpty ? null : startDateController.text}');
                    log('duration: ${durationController.text.isEmpty ? null : int.parse(durationController.text)}');

                    if (result == null) {
                      //! user did not upload image
                      log('image state provider runtimeType: ${ref.watch(imagePickedStateProvider).runtimeType}');
                      log('image state provider: ${ref.watch(imagePickedStateProvider)}');
                      log('user did not upload image');
                      final hasCreatedImageAds = await ref
                          .read(createAdvertControllerProvider.notifier)
                          .createAds(
                              advertiserId: int.parse(
                                  ref.watch(advertiserIdStateProvider)),
                              title: adTitleController.text.isEmpty
                                  ? null
                                  : adTitleController.text,
                              description: adDescriptionController.text.isEmpty
                                  ? null
                                  : adDescriptionController.text,
                              adType: 'image',
                              status: "drafts",
                              adSize: ref.watch(adSizeStateProvider),
                              mediaUrl: null,
                              // 'https://api-dev.wave5wireless.ng/content$trimmedData}',
                              targetUrl: targetUrlController.text.isEmpty
                                  ? null
                                  : targetUrlController.text,
                              budget: bugetController.text.isEmpty
                                  ? null
                                  : int.parse(bugetController.text),
                              duration: durationController.text.isEmpty
                                  ? null
                                  : int.parse(durationController.text),
                              startDate: startDateController.text.isEmpty
                                  ? null
                                  : startDateController.text,
                              businessCategory:
                                  businessCategoryController.text.isEmpty
                                      ? null
                                      : businessCategoryController.text,
                              deviceType: deviceTypeController.text.isEmpty
                                  ? null
                                  : deviceTypeController.text,
                              callToActionText:
                                  callToActionController.text.isEmpty
                                      ? null
                                      : callToActionController.text,
                              desiredScreen:
                                  desiredScreenController.text.isEmpty
                                      ? null
                                      : desiredScreenController.text,
                              regionIds: ref.watch(
                                          imageAdRegionIdStateProvider) ==
                                      null
                                  ? null
                                  : [ref.watch(imageAdRegionIdStateProvider)]);
                      if (hasCreatedImageAds) {
                        CustomSnackBar.showSnackBar(
                            context: context,
                            message:
                                'Image Advert saved to draft SuccessFully');
                        ref.invalidate(
                            getAdvertsByAdvertiserRepositoryFutureProvider(
                                ref.watch(advertiserIdStateProvider)));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const DraftScreen();
                        }));
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
                                  .read(createAdvertControllerProvider.notifier)
                                  .state
                                  .message ??
                              '',
                        );
                      }
                    } else {
                      //! user wants to  upload  image
                      log('image state provider runtimeType: ${ref.watch(imagePickedStateProvider).runtimeType}');
                      log('image state provider: ${ref.watch(imagePickedStateProvider)}');
                      log(' user wants to  upload  image');
                      final hasUploadedImage = await ref
                          .read(receiptFileUploadControllerProvider.notifier)
                          .uploadFile(
                              file: ref.watch(imagePickedStateProvider),
                              path: 'adverts');
                      if (hasUploadedImage) {
                        final data =
                            ref.read(receiptFileUploadControllerProvider).data;
                        final trimmedData =
                            data?.substring(data.indexOf('/adverts'));
                        log('trimmed Data: $trimmedData');

                        //! create  image adverts
                        final hasCreatedImageAds = await ref
                            .read(createAdvertControllerProvider.notifier)
                            .createAds(
                                advertiserId: int.parse(
                                    ref.watch(advertiserIdStateProvider)),
                                title: adTitleController.text.isEmpty
                                    ? null
                                    : adTitleController.text,
                                description:
                                    adDescriptionController.text.isEmpty
                                        ? null
                                        : adDescriptionController.text,
                                adType: 'image',
                                status: "drafts",
                                adSize: ref.watch(adSizeStateProvider),
                                mediaUrl:
                                    'https://api-dev.wave5wireless.ng/content/getImage$trimmedData',
                                targetUrl: targetUrlController.text.isEmpty
                                    ? null
                                    : targetUrlController.text,
                                budget: bugetController.text.isEmpty
                                    ? null
                                    : int.parse(bugetController.text),
                                duration: durationController.text.isEmpty
                                    ? null
                                    : int.parse(durationController.text),
                                startDate: startDateController.text.isEmpty
                                    ? null
                                    : startDateController.text,
                                businessCategory:
                                    businessCategoryController.text.isEmpty
                                        ? null
                                        : businessCategoryController.text,
                                deviceType: deviceTypeController.text.isEmpty
                                    ? null
                                    : deviceTypeController.text,
                                callToActionText:
                                    callToActionController.text.isEmpty
                                        ? null
                                        : callToActionController.text,
                                desiredScreen: desiredScreenController.text.isEmpty
                                    ? null
                                    : desiredScreenController.text,
                                regionIds: ref.watch(
                                            imageAdRegionIdStateProvider) ==
                                        null
                                    ? null
                                    : [ref.watch(imageAdRegionIdStateProvider)]);
                        if (hasCreatedImageAds) {
                          CustomSnackBar.showSnackBar(
                              context: context,
                              message:
                                  'Image Advert saved to draft SuccessFully');
                          ref.invalidate(
                              getAdvertsByAdvertiserRepositoryFutureProvider(
                                  ref.watch(advertiserIdStateProvider)));
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const DraftScreen();
                          }));
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
                                    .read(
                                        createAdvertControllerProvider.notifier)
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
                  },
                  bgColor: AppColors.lightPurple,
                  labelStyle: AppTheme.lightTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.w5Color, fontSize: 16.sp),
                ),
              ),
              60.wi,
              Expanded(
                child: AppElevatedButton(
                    label: 'Submit',
                    isActive: ref.watch(isModifyStateProvider) == true &&
                            ref.watch(typeStateProvider) == 'image'
                        ? true
                        : valiadteForm(),
                    isLoading: isDraftClicked == false
                        ? ref.watch(isModifyStateProvider) == true
                            ? ref
                                        .watch(
                                            receiptFileUploadControllerProvider)
                                        .status ==
                                    ResponseStatus.loading ||
                                ref.watch(updateAdsControllerProvider).status ==
                                    ResponseStatus.loading
                            : ref
                                        .watch(
                                            receiptFileUploadControllerProvider)
                                        .status ==
                                    ResponseStatus.loading ||
                                ref
                                        .watch(createAdvertControllerProvider)
                                        .status ==
                                    ResponseStatus.loading
                        : false,
                    onTap: ref.watch(isModifyStateProvider) == false
                        ? valiadteForm()
                            ? () async {
                                setState(() {
                                  isDraftClicked = false;
                                });
                                //! upload image endpoint
                                final hasUploadedImage = await ref
                                    .read(receiptFileUploadControllerProvider
                                        .notifier)
                                    .uploadFile(
                                        file:
                                            ref.watch(imagePickedStateProvider),
                                        path: 'adverts');
                                if (hasUploadedImage) {
                                  final data = ref
                                      .read(receiptFileUploadControllerProvider)
                                      .data;
                                  final trimmedData =
                                      data?.substring(data.indexOf('/adverts'));
                                  log('trimmed Data: $trimmedData');

                                  //! create  image adverts
                                  final hasCreatedImageAds = await ref
                                      .read(createAdvertControllerProvider
                                          .notifier)
                                      .createAds(
                                          advertiserId: int.parse(ref.watch(
                                              advertiserIdStateProvider)),
                                          title: adTitleController.text,
                                          description:
                                              adDescriptionController.text,
                                          adType: 'image',
                                          status: "pending",
                                          adSize:
                                              ref.watch(adSizeStateProvider),
                                          mediaUrl:
                                              'https://api-dev.wave5wireless.ng/content/getImage$trimmedData',
                                          targetUrl: targetUrlController.text,
                                          budget:
                                              int.parse(bugetController.text),
                                          duration: int.parse(
                                              durationController.text),
                                          startDate: startDateController.text,
                                          businessCategory:
                                              businessCategoryController.text,
                                          deviceType: deviceTypeController.text,
                                          callToActionText:
                                              callToActionController.text,
                                          desiredScreen:
                                              desiredScreenController.text,
                                          regionIds: [
                                        ref.watch(imageAdRegionIdStateProvider),
                                      ]);
                                  if (hasCreatedImageAds) {
                                    CustomSnackBar.showSnackBar(
                                        context: context,
                                        message:
                                            'Image Advert created SuccessFully');
                                    ref.invalidate(
                                        getAdvertsByAdvertiserRepositoryFutureProvider(
                                            ref.watch(
                                                advertiserIdStateProvider)));

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const AdsScreen();
                                    }));
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
                                              .read(
                                                  createAdvertControllerProvider
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
                            : () {}
                        : () async {
                            log('User wants to update ads');
                            //!check if user wants to upload new image
                            if (result == null) {
                              log('--User is not updating the advert image');
                              final hasUpdatedAdvert = await ref
                                  .read(updateAdsControllerProvider.notifier)
                                  .updateAdvert(
                                    advertId: ref.watch(advertIdStateProvider),
                                    advertiserId: int.parse(
                                        ref.watch(advertiserIdStateProvider)),
                                    adType: 'image',
                                    title: adTitleController.text,
                                    description: adDescriptionController.text,
                                    targetUrl: targetUrlController.text,
                                    budget: int.parse(bugetController.text),
                                    startDate: startDateController.text,
                                    duration:
                                        int.parse(durationController.text),
                                    deviceType: deviceTypeController.text,
                                    adSize: ref.watch(adSizeStateProvider),
                                    desiredScreen: desiredScreenController.text,
                                    callToActionText:
                                        callToActionController.text,
                                    businessCategory:
                                        businessCategoryController.text,
                                    mediaUrl: ref.watch(
                                        modifyDisplayContentStateProvider),
                                    regionIds: ref.watch(AdRegionStateProvider),
                                  );
                              if (hasUpdatedAdvert) {
                                log('advert(without updating new image) Updated succesfully!');
                                CustomSnackBar.showSnackBar(
                                    context: context,
                                    message:
                                        'Image Advert updated SuccessFully');
                                ref.invalidate(
                                    getAdvertsByAdvertiserRepositoryFutureProvider(
                                        ref.watch(advertiserIdStateProvider)));

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AdsScreen();
                                }));
                              } else {
                                log('advert(without updating new image) Not updated succesfully!');
                                CustomSnackBar.showSnackBar(
                                  context: context,
                                  isError: true,
                                  message: ref
                                          .read(updateAdsControllerProvider
                                              .notifier)
                                          .state
                                          .message ??
                                      '',
                                );
                              }
                            } else {
                              //! user wants to update the existing image advert
                              log('--user is  updating the advert image');
                              //! upload a new image to the  endpoint
                              final hasUploadedNewImage = await ref
                                  .read(receiptFileUploadControllerProvider
                                      .notifier)
                                  .uploadFile(
                                      file: ref.watch(imagePickedStateProvider),
                                      path: 'adverts');
                              if (hasUploadedNewImage) {
                                final data = ref
                                    .read(receiptFileUploadControllerProvider)
                                    .data;
                                final trimmedData =
                                    data?.substring(data.indexOf('/adverts'));
                                log('trimmed Data for uploading new image: $trimmedData');
                                //! update advert next
                                final hasUpdatedAdvertWithNewImage = await ref
                                    .read(updateAdsControllerProvider.notifier)
                                    .updateAdvert(
                                      advertId:
                                          ref.watch(advertIdStateProvider),
                                      advertiserId: int.parse(
                                          ref.watch(advertiserIdStateProvider)),
                                      adType: 'image',
                                      title: adTitleController.text,
                                      description: adDescriptionController.text,
                                      targetUrl: targetUrlController.text,
                                      budget: int.parse(bugetController.text),
                                      startDate: startDateController.text,
                                      duration:
                                          int.parse(durationController.text),
                                      deviceType: deviceTypeController.text,
                                      adSize: ref.watch(adSizeStateProvider),
                                      desiredScreen:
                                          desiredScreenController.text,
                                      callToActionText:
                                          callToActionController.text,
                                      businessCategory:
                                          businessCategoryController.text,
                                      mediaUrl:
                                          'https://api-dev.wave5wireless.ng/content/getImage$trimmedData',
                                      regionIds:
                                          ref.watch(AdRegionStateProvider),
                                    );
                                if (hasUpdatedAdvertWithNewImage) {
                                  log('advert(with updating new image) Updated succesfully!');
                                  CustomSnackBar.showSnackBar(
                                      context: context,
                                      message:
                                          'Image Advert Updated SuccessFully');
                                  ref.invalidate(
                                      getAdvertsByAdvertiserRepositoryFutureProvider(
                                          ref.watch(
                                              advertiserIdStateProvider)));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const AdsScreen();
                                  }));
                                } else {
                                  log('advert(with updating new image)Not  Updated succesfully!');
                                  CustomSnackBar.showSnackBar(
                                    context: context,
                                    isError: true,
                                    message: ref
                                            .read(updateAdsControllerProvider
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
                                log('Error during upload  new image process(for update advert)');
                              }
                            }
                          }),
              ),
            ],
          ),
          100.hi,
        ],
      ),
    );
  }
}
