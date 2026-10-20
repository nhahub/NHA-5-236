import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class DashboardFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const DashboardFeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: context.colorScheme.surface),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: context.colorScheme.onSurface.withValues(alpha: 0.03),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
              size: 22.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface,
              height: 1.6,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
