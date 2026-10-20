import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/domain/entity/instructor_profile_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'edit_profile_dialog.dart';

class InstructorBioDetails extends StatelessWidget {
  final InstructorProfileUIModel instructor;
  final bool expand;
  const InstructorBioDetails({
    super.key,
    required this.instructor,
    this.expand = false,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 5.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                context.tr('bio_and_details'),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(),
              CustomPrimaryButton(
                onTap: () {
                  final slug =
                      sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
                  final bloc = context.read<ProfileInstructorBloc>();
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: EditProfileDialog(
                        instructor: instructor,
                        slug: slug,
                      ),
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
          if (expand)
            Expanded(child: _buildDetailsList(context))
          else
            _buildDetailsList(context),
        ],
      ),
    );
  }

  Widget _buildDetailsList(BuildContext context) {
    return Column(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: expand
          ? MainAxisAlignment.spaceEvenly
          : MainAxisAlignment.start,
      children: [
        _buildDetailItem(
          context,
          Icons.person_2_outlined,
          context.tr('bio'),
          instructor.bio,
        ),
        _buildDetailItem(
          context,
          Icons.notes_rounded,
          context.tr('description'),
          instructor.description,
        ),
        _buildDetailItem(
          context,
          Icons.auto_awesome_outlined,
          context.tr('joined_at'),
          instructor.createdAt,
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: expand ? 12.h : 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: context.colorScheme.primary.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    fontSize: 14.sp,
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
