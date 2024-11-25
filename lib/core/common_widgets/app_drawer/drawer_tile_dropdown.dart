// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../features/advertiser/data/controller/create_advertiser_controller.dart';
import '../../../features/advertiser/data/controller/get_advertiser_id_controller.dart';
import '../../../features/advertiser/features/screens/create_ads_screen.dart';
import '../../../features/onboarding/data/controller/user_details_controller.dart';
import '../../enums.dart';
import '../../utils/app_colors.dart';
import '../../utils/themes/app_themes.dart';

final advertiseLoadingStateProvider = StateProvider<bool>((ref) => false);

// ignore: must_be_immutable
class DrawerTileDropDown extends ConsumerStatefulWidget {
  DrawerTileDropDown({
    required this.icon,
    required this.label,
    required this.subDrawer,
    this.padding,
    this.color,
    this.iconColor,
    this.labelColor,
    this.leftPadding,
    this.rightPadding,
    this.isAdvertise = false,
    Key? key,
  }) : super(key: key);

  final String icon, label;
  final Widget subDrawer;
  final Color? color, iconColor, labelColor;
  final EdgeInsetsGeometry? padding;
  final double? leftPadding, rightPadding;
  bool isAdvertise;

  @override
  _DrawerTileDropDownState createState() => _DrawerTileDropDownState();
}

class _DrawerTileDropDownState extends ConsumerState<DrawerTileDropDown> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    Widget childContent() {
      if (widget.isAdvertise == true) {
        log('---it is advertiser--');
        log('fetching AdvertiserId: ${ref.watch(fetchAdvertiserByUserIdControllerProvider).status == ResponseStatus.loading}');

        ref.watch(fetchAdvertiserByUserIdControllerProvider).status ==
                    ResponseStatus.loading ||
                ref.watch(createAdvertiserControllerProvider).status ==
                    ResponseStatus.loading
            ? const Text('I am loading...')
            // SizedBox(
            //     height: 30.h,
            //     width: 30.w,
            //     child: const CircularProgressIndicator(
            //       color: Colors.red,
            //     ),
            //   )
            : Row(
                children: [
                  SvgPicture.asset(
                    widget.icon,
                    color: widget.iconColor,
                  ),
                  16.wi,
                  SizedBox(
                    width: 149.w,
                    child: Text(
                      widget.label,
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        color:
                            widget.labelColor ?? AppColors.blackSupplementary,
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    isOpen ? AppIcons.arrowDown : AppIcons.curveArrowUp,
                    color: widget.iconColor,
                  ).padRight(20)
                ],
              );
      } else {
        log('---it is NOT advertiser--');
        Row(
          children: [
            SvgPicture.asset(
              widget.icon,
              color: widget.iconColor,
            ),
            16.wi,
            SizedBox(
              width: 149.w,
              child: Text(
                widget.label,
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  color: widget.labelColor ?? AppColors.blackSupplementary,
                  fontSize: 14.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              isOpen ? AppIcons.arrowDown : AppIcons.curveArrowUp,
              color: widget.iconColor,
            ).padRight(20)
          ],
        );
      }
      return Row(
        children: [
          SvgPicture.asset(
            widget.icon,
            color: widget.iconColor,
          ),
          16.wi,
          SizedBox(
            width: 149.w,
            child: Text(
              widget.label,
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                color: widget.labelColor ?? AppColors.blackSupplementary,
                fontSize: 14.sp,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            isOpen ? AppIcons.arrowDown : AppIcons.curveArrowUp,
            color: widget.iconColor,
          ).padRight(20)
        ],
      );
    }

    return Column(
      children: [
        GestureDetector(
          onTap: widget.isAdvertise
              ? () async {
                  // if (!mounted) return;

                  // try {
                  //   ref.read(advertiseLoadingStateProvider.notifier).state =
                  //       true;
                  //   //! check if user is an advertiser
                  //   final isAdvertiser = await ref
                  //       .read(
                  //           fetchAdvertiserByUserIdControllerProvider.notifier)
                  //       .getAdvertiserId(
                  //           userId: userDetailsController?.id.toString() ?? '');
                  //   //! checking the state of the fetchadvertiserId endpoint
                  //   final currentState =
                  //       ref.read(fetchAdvertiserByUserIdControllerProvider);
                  //   //! if advertiser doesn't exist,
                  //   if (currentState.status == ResponseStatus.notFound) {
                  //     final hasCreatedAdvertiser = await ref
                  //         .read(createAdvertiserControllerProvider.notifier)
                  //         .createAdvertiser(
                  //             name: userDetailsController?.name ??
                  //                 '${userDetailsController?.firstName} ${userDetailsController?.lastName}',
                  //             businessName:
                  //                 userDetailsController?.businessName ?? '',
                  //             userId: userDetailsController?.id ?? 0,
                  //             email: userDetailsController?.email ?? '');
                  //     if (!mounted) return;
                  //     if (hasCreatedAdvertiser) {
                  //       final isAdvertiser = await ref
                  //           .read(fetchAdvertiserByUserIdControllerProvider
                  //               .notifier)
                  //           .getAdvertiserId(
                  //               userId:
                  //                   userDetailsController?.id.toString() ?? '');

                  //       if (mounted) {
                  //         setState(() {
                  //           isOpen = !isOpen;
                  //         });
                  //       }
                  //       if (isAdvertiser && mounted) {
                  //         ref
                  //             .read(advertiseLoadingStateProvider.notifier)
                  //             .state = false;
                  //         final advertiserId = ref
                  //             .read(fetchAdvertiserByUserIdControllerProvider
                  //                 .notifier)
                  //             .state
                  //             .data
                  //             ?.id;
                  //         if (mounted) {
                  //           ref.read(advertiserIdStateProvider.notifier).state =
                  //               advertiserId ?? '';
                  //         }
                  //       }
                  //     } else {
                  //       ref.read(advertiseLoadingStateProvider.notifier).state =
                  //           false;
                  //     }
                  //   }
                  //   if (!mounted) return;
                  //   if (isAdvertiser) {
                  //     log('--user is an advertiser----');
                  //     final advertiserId = ref
                  //         .read(fetchAdvertiserByUserIdControllerProvider
                  //             .notifier)
                  //         .state
                  //         .data
                  //         ?.id;

                  //     if (mounted) {
                  //       ref.read(advertiserIdStateProvider.notifier).state =
                  //           advertiserId ?? '';
                  //       setState(() {
                  //         isOpen = !isOpen;
                  //       });
                  //     }
                  //     ref.read(advertiseLoadingStateProvider.notifier).state =
                  //         false;
                  //   } else {
                  //     //! create Advertiser
                  //   }
                  // } catch (e) {
                  //   ref.read(advertiseLoadingStateProvider.notifier).state =
                  //       false;
                  //   log('check if user is an Advertiser error: $e');
                  // }
                  if (!mounted) return;
                  try {
                    ref.read(advertiseLoadingStateProvider.notifier).state =
                        true;
                    final isAdvertiser = await ref
                        .read(
                            fetchAdvertiserByUserIdControllerProvider.notifier)
                        .getAdvertiserId(
                            userId: userDetailsController?.id.toString() ?? '');

                    if (!mounted) return;
                    final currentState =
                        ref.read(fetchAdvertiserByUserIdControllerProvider);
                    if (currentState.status == ResponseStatus.notFound) {
                      //! Create new advertiser
                      final hasCreatedAdvertiser = await ref
                          .read(createAdvertiserControllerProvider.notifier)
                          .createAdvertiser(
                              name: userDetailsController?.name ??
                                  '${userDetailsController?.firstName} ${userDetailsController?.lastName}',
                              businessName:
                                  userDetailsController?.businessName ?? '',
                              userId: userDetailsController?.id ?? 0,
                              email: userDetailsController?.email ?? '');

                      if (!mounted) return;
                      if (hasCreatedAdvertiser) {
                        //! Retry getting advertiser ID after creation
                        final isAdvertiser = await ref
                            .read(fetchAdvertiserByUserIdControllerProvider
                                .notifier)
                            .getAdvertiserId(
                                userId:
                                    userDetailsController?.id.toString() ?? '');

                        if (mounted) {
                          setState(() {
                            isOpen = !isOpen;
                          });
                        }
                        if (isAdvertiser && mounted) {
                          ref
                              .read(advertiseLoadingStateProvider.notifier)
                              .state = false;
                          final advertiserId = ref
                              .read(fetchAdvertiserByUserIdControllerProvider
                                  .notifier)
                              .state
                              .data
                              ?.id;
                          if (mounted) {
                            ref.read(advertiserIdStateProvider.notifier).state =
                                advertiserId ?? '';
                          }
                        }
                      }
                    } else if (isAdvertiser) {
                      //! Handle successful case
                      log('--user is an advertiser----');
                      final advertiserId = ref
                          .read(fetchAdvertiserByUserIdControllerProvider
                              .notifier)
                          .state
                          .data
                          ?.id;

                      if (mounted) {
                        ref.read(advertiserIdStateProvider.notifier).state =
                            advertiserId ?? '';
                        setState(() {
                          isOpen = !isOpen;
                        });
                      }
                    }

                    if (mounted) {
                      ref.read(advertiseLoadingStateProvider.notifier).state =
                          false;
                    }
                  } catch (e) {
                    if (mounted) {
                      ref.read(advertiseLoadingStateProvider.notifier).state =
                          false;
                    }
                    log('check if user is an Advertiser error: $e');
                  }
                }
              : () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
          child: Container(
              width: double.infinity,
              padding: isOpen
                  ? const EdgeInsets.all(16)
                  : widget.padding ?? EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: isOpen
                      ? widget.color ?? AppColors.w5Color.withOpacity(0.1)
                      : widget.color ?? Colors.transparent,
                  border: Border(
                      right: isOpen
                          ? const BorderSide(
                              color: AppColors.w5Color,
                              width: 5.0,
                            )
                          : BorderSide.none)),
              // child: childContent(),
              child: Row(
                children: [
                  SvgPicture.asset(
                    widget.icon,
                    color: widget.iconColor,
                  ),
                  16.wi,
                  SizedBox(
                    width: 149.w,
                    child: Text(
                      widget.label,
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        color:
                            widget.labelColor ?? AppColors.blackSupplementary,
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  ref.watch(advertiseLoadingStateProvider) == true &&
                          widget.isAdvertise == true
                      // &&
                      // ref
                      //         .watch(fetchAdvertiserByUserIdControllerProvider)
                      //         .status ==
                      //     ResponseStatus.loading
                      //                 ||
                      //         ref.watch(createAdvertiserControllerProvider).status ==
                      //             ResponseStatus.loading
                      ?
                      // SizedBox(
                      //     height: 30.h,
                      //     width: 30.w,
                      //     child: const CircularProgressIndicator(
                      //       color: Colors.red,
                      //     ),
                      //   )
                      const SpinKitChasingDots(
                          size: 20,
                          color: AppColors.white,
                        ).padRight(20)
                      : SvgPicture.asset(
                          isOpen ? AppIcons.arrowDown : AppIcons.curveArrowUp,
                          color: widget.iconColor,
                        ).padRight(20)
                ],
              )),
        ),
        8.hi,
        if (isOpen) widget.subDrawer
      ],
    ).padOnly(
        left: isOpen ? 0 : widget.leftPadding ?? 18,
        right: widget.rightPadding ?? 18);
  }
}
