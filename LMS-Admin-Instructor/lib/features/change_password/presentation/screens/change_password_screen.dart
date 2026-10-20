import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'widgets/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? 64.w : 8.w,
          ),
          child: InkWell(
            onTap: () => context.pop(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 16.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr('back'),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: context.isDesktop ? 80.h : 60.h,
      ),
      body: const SafeArea(child: ChangePasswordBody()),
    );
  }
}
