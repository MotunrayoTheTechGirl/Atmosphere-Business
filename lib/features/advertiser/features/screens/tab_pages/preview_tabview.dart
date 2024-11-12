import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common_widgets/app_image.dart';
import '../../widgets/preview_custom_row.dart';

class PreviewTabView extends StatelessWidget {
  const PreviewTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .9.sh,
      child: Column(
        children: [
          AppImage(
            url:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF_2tVojDd1gBpXsiXvKyYwgLpujpU-NQh_A&s',
            width: double.infinity,
            height: 217.h,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          24.hi,
          const PreviewCustomRow(
            prefix: 'Device Type',
            suffix: 'Mobile',
          ),
          13.hi,
          const PreviewCustomRow(
            prefix: 'Ad Size',
            suffix: '320X100',
          ),
          13.hi,
          const PreviewCustomRow(
            prefix: 'Desired Screen',
            suffix: 'Welcome Page',
          ),
          13.hi,
          const PreviewCustomRow(
            prefix: 'Ad Placement',
            suffix: 'Top of Screen',
          ),
          13.hi,
          const PreviewCustomRow(
            prefix: 'Ad Type',
            suffix: 'Image',
          ),
        ],
      ),
    );
  }
}
