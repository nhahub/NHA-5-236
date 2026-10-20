import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingsSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(
            title.toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: context.colorScheme.onSurface.withValues(alpha: 0.05),
            ),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}
