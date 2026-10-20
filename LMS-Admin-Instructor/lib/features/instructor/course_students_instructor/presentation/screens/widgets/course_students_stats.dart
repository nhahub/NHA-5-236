import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_desktop.dart';

class CourseStudentsStats extends StatelessWidget {
  const CourseStudentsStats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseStatsBloc, CourseStatsState>(
      builder: (context, state) {
        if (state is CourseStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CourseStatsLoaded) {
          final s = state.courseStats;
          return Wrap(
            spacing: context.responsiveValue(mobile: 16.w, desktop: 30.w),
            runSpacing: context.responsiveValue(mobile: 16.h, desktop: 30.h),
            alignment: WrapAlignment.center,
            children: [
              CustomCardStatusInfoDesktop(
                title: context.tr('total_videos'),
                value: s.totalVideos.toString(),
                icon: Icons.video_collection_outlined,
                color: context.colorScheme.primary,
              ),
              CustomCardStatusInfoDesktop(
                title: context.tr('total_materials'),
                value: s.totalMaterials.toString(),
                icon: Icons.description_outlined,
                color: context.colorScheme.secondary,
              ),
              CustomCardStatusInfoDesktop(
                title: context.tr('total_students'),
                value: s.totalStudents.toString(),
                icon: Icons.people_outline,
                color: context.colorScheme.tertiary,
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
