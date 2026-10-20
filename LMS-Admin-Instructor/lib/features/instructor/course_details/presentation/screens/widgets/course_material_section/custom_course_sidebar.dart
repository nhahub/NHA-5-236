import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';

class CustomCourseSidebar extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onManage;
  final String? manageText;
  final List<Widget> children;
  const CustomCourseSidebar({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onManage,
    this.manageText,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Icon(icon, size: 20.sp, color: color),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onManage != null) ...[
                  TextButton(
                    onPressed: onManage,
                    child: Text(
                      manageText ?? context.tr('show_more'),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.colorScheme.outline.withValues(alpha: 0.3),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
