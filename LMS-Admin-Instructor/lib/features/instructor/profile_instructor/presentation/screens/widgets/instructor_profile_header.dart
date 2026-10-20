import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/domain/entity/instructor_profile_ui_model.dart';

class InstructorProfileHeader extends StatelessWidget {
  final InstructorProfileUIModel instructor;
  const InstructorProfileHeader({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                instructor.fullName,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.colorScheme.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          Text(
            context.tr('instructor'),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            instructor.email,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          Divider(
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.1),
          ),
          SizedBox(height: 48.h),
          Container(
            width: 280.w,
            height: 280.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                width: 20.w,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: instructor.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: context.colorScheme.primary,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  size: 100.sp,
                  color: context.colorScheme.outlineVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
