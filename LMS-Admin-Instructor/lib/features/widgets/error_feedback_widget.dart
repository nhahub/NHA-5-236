import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class ErrorFeedbackWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;
  final double? height;

  const ErrorFeedbackWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200.h,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: context.colorScheme.error,
                size: 24.sp,
              ),
              SizedBox(height: 12.h),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              if (onRetry != null) ...[
                SizedBox(height: 16.h),
                CustomPrimaryButton(
                  text: context.tr('retry'),
                  onTap: onRetry,
                  width: 150,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
