import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import '../../../../domain/entity/package_details_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/bloc/package_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_bloc.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'edit_package_dialog.dart';

class PackageInfoCard extends StatelessWidget {
  final PackageDetailsUIModel package;

  const PackageInfoCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop ? 38.r : 16.r,
              vertical: context.isDesktop ? 30.r : 16.r,
            ),
            child: _buildMainInfo(context),
          ),
          Divider(
            height: 1,
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop ? 32.r : 16.r,
              vertical: context.isDesktop ? 20.r : 16.r,
            ),
            child: _buildStats(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (context.isDesktop)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTitle(context)),
              _buildActionButtons(context),
            ],
          )
        else ...[
          _buildTitle(context),
          SizedBox(height: 16.h),
          _buildActionButtons(context),
        ],
        SizedBox(height: 16.h),
        Text(
          package.description.isNotEmpty
              ? package.description
              : context.tr('course_desc_placeholder'),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      package.title.isNotEmpty
          ? package.title
          : context.tr('course_title_placeholder'),
      style: context.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: context.isDesktop ? null : 20.sp,
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    final stats = [
      _StatItem(
        icon: Icons.payments_outlined,
        label: context.tr('price_label'),
        value: "${package.price} ${context.tr('EGP')}",
        color: Colors.green.shade50,
        iconColor: Colors.green,
      ),
      _StatItem(
        icon: Icons.folder_copy_outlined,
        label: context.tr('courses_count'),
        value: package.coursesCount.toString(),
        color: Colors.blue.shade50,
        iconColor: Colors.blue,
      ),
    ];

    return context.isDesktop
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: stats.map((stat) => Padding(
              padding: EdgeInsets.only(right: 32.w),
              child: stat,
            )).toList(),
          )
        : Wrap(spacing: 16.w, runSpacing: 16.h, children: stats);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeaderButton(context, context.tr('edit_details'), false, () {
          final packageDetailsBloc = context.read<PackageDetailsBloc>();
          showDialog(
            context: context,
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: packageDetailsBloc,
                ),
                BlocProvider(
                  create: (context) => sl<PackagesInstructorBloc>(),
                ),
              ],
              child: EditPackageDialog(package: package),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHeaderButton(
    BuildContext context,
    String text,
    bool isPrimary,
    VoidCallback onTap, {
    IconData? icon,
  }) {
    return SizedBox(
      height: 40.h,
      child: isPrimary
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: icon != null
                  ? Icon(icon, size: 18.sp, color: context.colorScheme.surface)
                  : const SizedBox.shrink(),
              label: Text(
                text,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(
                Icons.edit_outlined,
                size: 18.sp,
                color: context.colorScheme.onSurface,
              ),
              label: Text(
                text,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.secondary,
                foregroundColor: context.colorScheme.onSecondary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
            ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color iconColor;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: context.isDesktop ? 150.w : 140.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Text(
                value,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
