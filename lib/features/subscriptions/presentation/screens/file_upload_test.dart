import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_elevated_button.dart';

class FileUploadTest extends StatelessWidget {
  const FileUploadTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 202.w,
              child: AppElevatedButton(
                borderRadius: 8,
                labelFontSize: 14.sp,
                label: 'Submit Bank Receipt',
                onTap: () {
                  // customAlertDialog(context: context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
