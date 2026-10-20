import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? iconColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      leading: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: (iconColor ?? context.colorScheme.primary).withValues(
            alpha: 0.1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          color: iconColor ?? context.colorScheme.primary,
          size: 22.sp,
        ),
      ),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: titleColor ?? context.colorScheme.onSurface,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing:
          trailing ??
          (onTap != null
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: context.colorScheme.onSurfaceVariant,
                )
              : null),
    );
  }
}
