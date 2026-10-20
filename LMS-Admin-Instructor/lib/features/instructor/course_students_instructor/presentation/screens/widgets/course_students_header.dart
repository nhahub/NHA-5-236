import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_state.dart';

class CourseStudentsHeader extends StatelessWidget {
  final String slug;

  const CourseStudentsHeader({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumbs(context),
            SizedBox(height: 24.h),
            BlocBuilder<CourseStatsBloc, CourseStatsState>(
              builder: (context, state) {
                String title = context.tr('analytics');
                if (state is CourseStatsLoaded) {
                  title = state.courseStats.courseTitle;
                }
                return Text(
                  title,
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                );
              },
            ),
          ],
        ),
        CustomPrimaryButton(
          text: context.tr('edit_course'),
          prefixIcon: const Icon(Icons.edit_outlined),
          onTap: () => context.pushNamed(
            AppRoutes.courseDetails,
            pathParameters: {'slug': slug},
          ),
          width: context.isMobile ? 140.w : 180.w,
          height: context.isMobile ? 40.h : 50.h,
        ),
      ],
    );
  }

  Widget _buildBreadcrumbs(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Text(
            context.tr('courses'),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
        Icon(
          Icons.chevron_right,
          size: 16.sp,
          color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        Text(
          context.tr('students'),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
