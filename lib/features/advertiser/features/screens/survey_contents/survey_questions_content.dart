import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/themes/app_themes.dart';

class SurveyQuestionsContent extends StatefulWidget {
  const SurveyQuestionsContent({Key? key}) : super(key: key);

  @override
  _SurveyQuestionsContentState createState() => _SurveyQuestionsContentState();
}

class _SurveyQuestionsContentState extends State<SurveyQuestionsContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Survey Question',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
