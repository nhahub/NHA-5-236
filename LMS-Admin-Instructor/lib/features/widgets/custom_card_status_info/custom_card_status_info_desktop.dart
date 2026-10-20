import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';

class CustomCardStatusInfoDesktop extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const CustomCardStatusInfoDesktop({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  State<CustomCardStatusInfoDesktop> createState() =>
      _CustomCardStatusInfoDesktopState();
}

class _CustomCardStatusInfoDesktopState
    extends State<CustomCardStatusInfoDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(mobile: 16.r, desktop: 24.r),
        vertical: context.responsiveValue(mobile: 12.r, desktop: 16.r),
      ),
      width: 300.w,
      constraints: BoxConstraints(
        minHeight: context.responsiveValue(mobile: 80.h, desktop: 115.h),
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.3),
            blurRadius: 1,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.value,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(widget.icon, color: widget.color),
          ),
        ],
      ),
    );
  }
}
