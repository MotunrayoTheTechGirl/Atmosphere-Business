import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropdownButton<T> extends ConsumerStatefulWidget {
  const AppDropdownButton({
    Key? key,
    this.title,
    this.margin = 0,
    required this.items,
    required this.onChanged,
    this.fontSize,
    this.value,
    this.focusNode,
    this.hint,
    this.isFilled = false,
    this.color,
  }) : super(key: key);

  final String? title;
  final double? fontSize;
  final double? margin;
  final FocusNode? focusNode;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final String? hint;
  final bool isFilled;
  final Color? color;

  @override
  AppDropdownButtonState<T> createState() => AppDropdownButtonState<T>();
}

class AppDropdownButtonState<T> extends ConsumerState<AppDropdownButton<T>> {
  bool _isFocused = false;
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.title == null)
            const SizedBox.shrink()
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.title ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          FocusScope(
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  _isFocused = hasFocus;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.textFieldBorder.withOpacity(0.2),
                  ),
                ),
                child: DropdownButton<T>(
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.greyText,
                  ),
                  value: widget.value,
                  focusNode: myFocusNode,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppColors.black,
                  ),
                  hint: widget.hint != null
                      ? Text(
                          widget.hint!,
                          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.greyText,
                          ),
                        )
                      : const SizedBox.shrink(),
                  underline: const SizedBox.shrink(),
                  items: widget.items,
                  onChanged: widget.onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
