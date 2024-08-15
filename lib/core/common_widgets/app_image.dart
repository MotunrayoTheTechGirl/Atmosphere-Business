import 'package:cached_network_image/cached_network_image.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final bool hasGradient;
  final String tag;
  final double margin;

  const AppImage({
    super.key,
    this.url = '',
    this.width = 120,
    this.height = 120,
    required this.borderRadius,
    this.hasGradient = false,
    this.tag = '',
    this.margin = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
              margin: EdgeInsets.all(margin),
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(0.2),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                ),
              )
              // BoxDecoration(
              //   color: AppColors.primaryColor.withOpacity(0.5),
              //   borderRadius: borderRadius,
              //   image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: imageProvider,
              //   ),
              // ),
              ),
          placeholder: (context, url) => Container(
            margin: EdgeInsets.all(margin),
            width: width,
            height: height,
            child: const SpinKitDoubleBounce(
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            margin: EdgeInsets.all(margin),
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.2),
            ),
            // BoxDecoration(
            //   borderRadius: borderRadius,
            //   color: AppColors.primaryColor.withOpacity(0.5),
            // ),
            child: Center(
              child: Text(
                tag.getInitials(),
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  // fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
        if (hasGradient)
          Container(
              width: width,
              height: height,
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.grey.withOpacity(0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 1.0],
                ),
              ))
      ],
    );
  }
}
