import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/advertiser_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common_widgets/app_image.dart';
import '../../../../../core/common_widgets/app_video_player.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../widgets/preview_custom_row.dart';

class PreviewTabView extends ConsumerStatefulWidget {
  const PreviewTabView({Key? key}) : super(key: key);

  @override
  _PreviewTabviewState createState() => _PreviewTabviewState();
}

class _PreviewTabviewState extends ConsumerState<PreviewTabView> {
  Widget contentPreview() {
    if (ref.watch(typeStateProvider) == 'image') {
      return AppImage(
        url: ref.watch(contentUrlStateProvider),
        width: double.infinity,
        height: 217.h,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        errorDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: AppColors.w5Color.withOpacity(0.1),
        ),
      );
    } else if (ref.watch(typeStateProvider) == 'video') {
      return AppVideoPlayer(videoUrl: ref.watch(contentUrlStateProvider)
          // 'https://static.videezy.com/system/resources/previews/000/055/284/original/20201011_savings_78.mp4',
          );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .9.sh,
      child: Column(
        children: [
          contentPreview(),
          24.hi,
          PreviewCustomRow(
            prefix: 'Device Type',
            suffix: ref.watch(deviceStateProvider),
          ),
          13.hi,
          PreviewCustomRow(
            prefix: 'Ad Size',
            suffix: ref.watch(sizeStateProvider),
          ),
          13.hi,
          PreviewCustomRow(
            prefix: 'Desired Screen',
            suffix: ref.watch(screenStateProvider),
          ),
          13.hi,
          PreviewCustomRow(
            prefix: 'Ad Type',
            suffix: ref.watch(typeStateProvider),
          ),
        ],
      ),
    );
  }
}
