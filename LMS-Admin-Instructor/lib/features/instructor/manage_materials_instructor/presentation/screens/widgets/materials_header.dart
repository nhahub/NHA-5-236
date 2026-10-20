import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';

class MaterialsHeader extends StatelessWidget {
  final String courseName;

  const MaterialsHeader({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseName,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.tr('course_materials'),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
