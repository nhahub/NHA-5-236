import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final ButtonStyle? style;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.textStyle,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200.w,
      height: height ?? 50.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: style ??
            OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              side: BorderSide(
                width: 2.w,
                color: context.colorScheme.primary.withValues(alpha: 0.2),
              ),
            ),
        child: Text(
          text,
          style: textStyle ??
              context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
