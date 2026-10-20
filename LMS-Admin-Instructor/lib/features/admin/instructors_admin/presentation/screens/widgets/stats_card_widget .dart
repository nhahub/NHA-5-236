import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class StatsCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final String? footerText;
  final IconData? icon;
  final Color? iconColor;
  final Color? backGroundIconColor;
  final Color? valueColor;
  final VoidCallback? onTap;

  const StatsCardWidget({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.footerText,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.onTap,
    this.backGroundIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 530.w,
        height: 180.h,
        padding: EdgeInsets.all(25.r),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const Spacer(),
                if (icon != null) ...[
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: backGroundIconColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? context.colorScheme.primary,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
              ],
            ),
            SizedBox(height: 12.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: valueColor ?? context.colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              footerText ?? "",
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
