// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/ads_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/draft_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/overview_tabview.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../../core/enums.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../../../subscriptions/data/controller/file_upload_controller.dart';
import '../../../data/controller/create_advert_controller.dart';
import '../../../data/controller/update_ads_controller.dart';
import '../../../data/repository/get_adverts_repository.dart';
import '../../../data/repository/region_repository.dart';
import '../../../logic/multiple_region_selection_notifier.dart';
import '../../../logic/selected_region_id_state_notifier.dart';
import '../../widgets/size_guide_text_button.dart';
import '../../widgets/textfield_with_inline_label.dart';
import '../../widgets/upload_box_text.dart';
import '../advertiser_overview_screen.dart';
import '../create_ads_screen.dart';

final videoAdSizeStateProvider = StateProvider<String?>((ref) => null);
// final videoUrlStateProvider = StateProvider<String>((ref) => '');
final videoPickedStateProvider = StateProvider<File>((ref) => File(''));
final videoAdRegionIdStateProvider = StateProvider<String?>((ref) => null);

class VideoAdsTabView extends ConsumerStatefulWidget {
  const VideoAdsTabView({Key? key}) : super(key: key);

  @override
  _VideoAdsTabViewState createState() => _VideoAdsTabViewState();
}

class _VideoAdsTabViewState extends ConsumerState<VideoAdsTabView> {
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
      adTitleController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyTitleStateProvider)
          : '';
      adDescriptionController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyDescriptionStateProvider)
          : '';
      targetUrlController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyTargetStateProvider)
          : '';
      bugetController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyBudgetStateProvider)
          : '';
      durationController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyDurationStateProvider)
          : '';
      startDateController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyStartDateStateProvider).split(' ')[0]
          : '';
      deviceTypeController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyDeviceStateProvider)
          : '';
      desiredScreenController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifydesiredScreenStateProvider)
          : '';
      callToActionController.text = ref.watch(typeStateProvider) == 'video'
          ? ref.watch(modifyCallToActionStateProvider)
          : '';
      businessCategoryController.text = ref.watch(typeStateProvider) == 'video'
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
        ref.read(videoAdSizeStateProvider.notifier).state = '298 x 142';
      });
      return TextEditingController(text: '298 x 142');
    } else if (textEditingController.text == 'Desktop') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(videoAdSizeStateProvider.notifier).state = '741 x 170';
      });
      return TextEditingController(text: '741 x 170');
    }
    return TextEditingController();
  }

  bool isDraftClicked = false;
  @override
  Widget build(BuildContext context) {
    final regionFutureController = ref.watch(adsRegionRepositoryFutureProvider);
    final selectedRegion = ref.watch(selectedRegionProvider);
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
            keyboardType: TextInputType.number,
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
                  hintText: 'e.g 10 Days',
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
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            readOnly: true,
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 580.h, 0, 60.w),
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
            controller: desiredScreenController,
            label: 'Desired Screen',
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 650.h, 0, 60.w),
                color: AppColors.white,
                items: [
                  'Welcome Screen',
                  'Login Screen',
                  'Dashboard Screen',
                  'Data and subscription Screen',
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
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            readOnly: true,
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 650.h, 0, 60.w),
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
                ref.read(videoAdRegionIdStateProvider.notifier).state =
                    selected['id'].toString();
                setState(() {
                  regionController.text = selected['area'];
                });
                ref
                    .read(selectedRegionProvider.notifier)
                    .toggle(selected['area']);
                ref
                    .read(selectedRegionIdProvider.notifier)
                    .addSelectedIdRegion(selected['id']);
              }
            },
          ),
          Wrap(
              spacing: 8,
              children: selectedRegion
                  .map((region) => Chip(
                        label: Text(region),
                        onDeleted: () {
                          ref
                              .read(selectedRegionProvider.notifier)
                              .toggle(region);
                          // ref.read(selectedRegionIdProvider.notifier).removeSelectedIdRegion()
                        },
                      ))
                  .toList()),
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
                final pickedVideoResult = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.video,
                );
                if (pickedVideoResult == null) {
                  log("No file selected");
                } else {
                  setState(() {});
                  for (var element in pickedVideoResult.files) {
                    log('Selected video: ${element.name}');
                    log('Selected video size: ${result?.files.first.extension ?? ''} | ${(pickedVideoResult.files.first.size) / 1024}MB');
                  }
                  if (pickedVideoResult.files.isNotEmpty) {
                    final file = pickedVideoResult.files.first;
                    final fileSize = file.size;
                    if (fileSize < 1024 || fileSize > 1024 * 1024 * 5) {
                      setState(() {
                        result = null;
                      });
                      log('video size above limit');
                      CustomSnackBar.showSnackBar(
                        context: context,
                        message: 'Video size must be between 1 KB and 5 MB',
                      );
                    } else {
                      setState(() {
                        result = pickedVideoResult;
                        final resultFile =
                            File(pickedVideoResult.files.first.path ?? '');
                        ref.read(videoPickedStateProvider.notifier).state =
                            resultFile;

                        log('final result = $result');
                      });
                      ref
                          .read(modifyDisplayContentStateProvider.notifier)
                          .state = result?.files.first.name ?? '';
                      log('Selected video: ${file.name}');
                    }
                    // try {
                    //   // upload image endpoint
                    //   await ref
                    //       .read(receiptFileUploadControllerProvider.notifier)
                    //       .uploadFile(file: file);

                    //   log('file upload successful');
                    //   final data =
                    //       ref.read(receiptFileUploadControllerProvider).data;
                    //   final trimmedData =
                    //       data?.substring(data.indexOf('/dealer'));
                    //   log('trimmed Data: $trimmedData');
                    //   ref.read(videoUrlStateProvider.notifier).state =
                    //       trimmedData ?? '';
                    //   //! value for createAds endpoint expects
                    //   //'https://api-dev.wave5wireless.ng/content$trimmedData'
                    // } catch (e) {
                    //   log('Error during upload process: $e');
                    //   CustomSnackBar.showSnackBar(
                    //       context: context,
                    //       message: 'An error occurred during upload');
                    // }
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
                              ref.watch(typeStateProvider) == 'video'
                          ? Text(ref
                              .watch(modifyDisplayContentStateProvider)
                              .substring(ref
                                      .watch(modifyDisplayContentStateProvider)
                                      .lastIndexOf('/') +
                                  1))
                          : result != null
                              ? Text(' ${result?.files.first.name}')
                              : const UploadBoxText()
                      // result != null
                      //     ? Text(' ${(result?.files.first.name)}')
                      //     : const UploadBoxText(
                      //         isVideo: true,
                      //       ),
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
                    if (result == null) {
                      final hasCreatedVideoAds = await ref
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
                              adType: 'video',
                              status: "drafts",
                              adSize: ref.watch(videoAdSizeStateProvider),
                              mediaUrl: '',
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
                              regionIds: ref.watch(selectedRegionIdProvider)
                              // ref.watch(videoAdRegionIdStateProvider) == null
                              //     ? null
                              //     : [ref.watch(videoAdRegionIdStateProvider)],
                              );
                      if (hasCreatedVideoAds) {
                        CustomSnackBar.showSnackBar(
                            context: context,
                            message:
                                'Video Advert saved to draft SuccessFully');
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
                        ref.read(selectedRegionProvider.notifier).clear();
                        ref.read(selectedRegionIdProvider.notifier).clear();
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
                      log('user wants to upload video');
                      //! upload video endpoint
                      final hasUploadedVideo = await ref
                          .read(receiptFileUploadControllerProvider.notifier)
                          .uploadFile(
                              file: ref.watch(videoPickedStateProvider),
                              path: 'adverts');
                      if (hasUploadedVideo) {
                        final data =
                            ref.read(receiptFileUploadControllerProvider).data;
                        final trimmedData =
                            data?.substring(data.indexOf('/adverts'));
                        log('trimmed Data: $trimmedData');
                        //! create  video adverts
                        final hasCreatedVideoAds = await ref
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
                                adType: 'video',
                                status: "drafts",
                                adSize: ref.watch(videoAdSizeStateProvider),
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
                                desiredScreen:
                                    desiredScreenController.text.isEmpty
                                        ? null
                                        : desiredScreenController.text,
                                regionIds: ref.watch(selectedRegionIdProvider)
                                // ref.watch(
                                //             videoAdRegionIdStateProvider) ==
                                //         null
                                //     ? null
                                //     : [ref.watch(videoAdRegionIdStateProvider)],
                                );
                        if (hasCreatedVideoAds) {
                          CustomSnackBar.showSnackBar(
                              context: context,
                              message:
                                  'Video Advert saved to draft SuccessFully');
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
                          ref.read(selectedRegionProvider.notifier).clear();
                          ref.read(selectedRegionIdProvider.notifier).clear();
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
                              'Oops! Video size must be between 1 KB and 5 MB '
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
                            ref.watch(typeStateProvider) == 'video'
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
                    // isDraftClicked == false
                    //     ? ref.watch(receiptFileUploadControllerProvider).status ==
                    //             ResponseStatus.loading ||
                    //         ref.watch(createAdvertControllerProvider).status ==
                    //             ResponseStatus.loading
                    //     : false,
                    onTap: ref.watch(isModifyStateProvider) == false
                        ? valiadteForm()
                            ? () async {
                                setState(() {
                                  isDraftClicked = false;
                                });
                                //! upload video endpoint
                                final hasUploadedVideo = await ref
                                    .read(receiptFileUploadControllerProvider
                                        .notifier)
                                    .uploadFile(
                                        file:
                                            ref.watch(videoPickedStateProvider),
                                        path: 'adverts');
                                if (hasUploadedVideo) {
                                  final data = ref
                                      .read(receiptFileUploadControllerProvider)
                                      .data;
                                  final trimmedData =
                                      data?.substring(data.indexOf('/adverts'));
                                  log('trimmed Data: $trimmedData');
                                  //! create  video adverts
                                  final hasCreatedVideoAds = await ref
                                      .read(createAdvertControllerProvider
                                          .notifier)
                                      .createAds(
                                        advertiserId: int.parse(ref
                                            .watch(advertiserIdStateProvider)),
                                        title: adTitleController.text,
                                        description:
                                            adDescriptionController.text,
                                        adType: 'video',
                                        status: "pending",
                                        adSize:
                                            ref.watch(videoAdSizeStateProvider),
                                        mediaUrl:
                                            // 'https://api-dev.wave5wireless.ng/content$trimmedData',
                                            'https://api-dev.wave5wireless.ng/content/getImage$trimmedData',
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
                                        desiredScreen:
                                            desiredScreenController.text,
                                        regionIds:
                                            ref.watch(selectedRegionIdProvider),
                                        // [
                                        //   ref.watch(videoAdRegionIdStateProvider)
                                        // ],
                                      );
                                  if (hasCreatedVideoAds) {
                                    CustomSnackBar.showSnackBar(
                                        context: context,
                                        message:
                                            'Video Advert updated SuccessFully');
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
                                    ref
                                        .read(selectedRegionProvider.notifier)
                                        .clear();
                                    ref
                                        .read(selectedRegionIdProvider.notifier)
                                        .clear();
                                  }
                                } else {
                                  CustomSnackBar.showSnackBar(
                                    context: context,
                                    isError: true,
                                    message:
                                        'Oops! Video size must be between 1 KB and 5 MB '
                                        '',
                                  );
                                  log('Error during upload process');
                                }
                              }
                            : () {}
                        : () async {
                            log('User wants to update video ads');
                            //!check if user wants to upload new video
                            if (result == null) {
                              log('--User is not updating the advert video');
                              final hasUpdatedAdvert = await ref
                                  .read(updateAdsControllerProvider.notifier)
                                  .updateAdvert(
                                    advertId: ref.watch(advertIdStateProvider),
                                    advertiserId: int.parse(
                                        ref.watch(advertiserIdStateProvider)),
                                    adType: 'video',
                                    title: adTitleController.text,
                                    description: adDescriptionController.text,
                                    targetUrl: targetUrlController.text,
                                    budget: int.parse(bugetController.text),
                                    startDate: startDateController.text,
                                    duration:
                                        int.parse(durationController.text),
                                    deviceType: deviceTypeController.text,
                                    adSize: ref.watch(videoAdSizeStateProvider),
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
                                log('advert(without updating new video) Updated succesfully!');
                                CustomSnackBar.showSnackBar(
                                    context: context,
                                    message:
                                        'Video Advert updated SuccessFully');
                                ref.invalidate(
                                    getAdvertsByAdvertiserRepositoryFutureProvider(
                                        ref.watch(advertiserIdStateProvider)));

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AdsScreen();
                                }));
                              } else {
                                log('advert(without updating new video) Not updated succesfully!');
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
                              //! user wants to update the existing video advert
                              log('--user is  updating the advert video');
                              //! upload a new video to the  endpoint
                              final hasUploadedNewImage = await ref
                                  .read(receiptFileUploadControllerProvider
                                      .notifier)
                                  .uploadFile(
                                      file: ref.watch(videoPickedStateProvider),
                                      path: 'adverts');
                              if (hasUploadedNewImage) {
                                final data = ref
                                    .read(receiptFileUploadControllerProvider)
                                    .data;
                                final trimmedData =
                                    data?.substring(data.indexOf('/adverts'));
                                log('trimmed Data for uploading new video: $trimmedData');
                                //! update advert next
                                final hasUpdatedAdvertWithNewVideo = await ref
                                    .read(updateAdsControllerProvider.notifier)
                                    .updateAdvert(
                                      advertId:
                                          ref.watch(advertIdStateProvider),
                                      advertiserId: int.parse(
                                          ref.watch(advertiserIdStateProvider)),
                                      adType: 'video',
                                      title: adTitleController.text,
                                      description: adDescriptionController.text,
                                      targetUrl: targetUrlController.text,
                                      budget: int.parse(bugetController.text),
                                      startDate: startDateController.text,
                                      duration:
                                          int.parse(durationController.text),
                                      deviceType: deviceTypeController.text,
                                      adSize:
                                          ref.watch(videoAdSizeStateProvider),
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
                                if (hasUpdatedAdvertWithNewVideo) {
                                  log('advert(with updating new video) Updated succesfully!');
                                  CustomSnackBar.showSnackBar(
                                      context: context,
                                      message:
                                          'Video Advert Updated SuccessFully');
                                  ref.invalidate(
                                      getAdvertsByAdvertiserRepositoryFutureProvider(
                                          ref.watch(
                                              advertiserIdStateProvider)));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const AdsScreen();
                                  }));
                                } else {
                                  log('advert(with updating new video)Not  Updated succesfully!');
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
                                log('Error during upload  new video process(for update advert)');
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
