import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/domain/entity/admin_profile_ui_model.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class AdminProfileHeader extends StatelessWidget {
  final AdminProfileUIModel profile;
  const AdminProfileHeader({super.key, required this.profile});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr('profile'),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              CustomPrimaryButton(
                onTap: () {
                  // TODO: Implement Edit Profile for Admin when endpoint is ready
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.tr('edit_coming_soon')),
                      backgroundColor: context.colorScheme.secondary,
                    ),
                  );
                },
                prefixIcon: Icon(
                  Icons.edit_outlined,
                  size: 18.sp,
                  color: context.colorScheme.onPrimary,
                ),
                text: context.tr('edit'),
                width: 110.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.1),
          ),
          SizedBox(height: 32.h),
          Container(
            width: 200.w,
            height: 200.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                width: 15.w,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: profile.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: context.colorScheme.primary,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  size: 80.sp,
                  color: context.colorScheme.outlineVariant,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            profile.fullName,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colorScheme.onSurface,
              letterSpacing: -0.2,
            ),
          ),
          Text(
            context.tr('lms_admin'),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 32.h),
          _buildInfoRow(
            context,
            Icons.email_rounded,
            context.tr('email_label'),
            profile.email,
          ),
          _buildInfoRow(
            context,
            Icons.calendar_today,
            context.tr('joined_at'),
            profile.formattedJoinedDate,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.3,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            child: Icon(icon, size: 20.sp, color: context.colorScheme.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
