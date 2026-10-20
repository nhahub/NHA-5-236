import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final double? height;
  final Color? color;
  final double strokeWidth;

  const LoadingIndicatorWidget({
    super.key,
    this.height,
    this.color,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200.h,
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? context.colorScheme.primary,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
