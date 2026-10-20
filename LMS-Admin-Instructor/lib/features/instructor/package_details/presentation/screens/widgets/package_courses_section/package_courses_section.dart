import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/course_card_horizontal.dart';
import '../../../../domain/entity/package_details_ui_model.dart';

class PackageCoursesSection extends StatelessWidget {
  final List<PackageCourseItemUIModel> courses;

  const PackageCoursesSection({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('courses_included'),
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 24.h),
        if (courses.isEmpty)
          Center(
            child: Text(
              context.tr('no_courses_found'),
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isDesktop ? 2 : 1,
              crossAxisSpacing: 24.w,
              mainAxisSpacing: 24.h,
              mainAxisExtent: 160.h,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return CourseCardHorizontal(
                title: course.title,
                imagePath: course.image,
                instructorName: course.instructorName,
                rating: course.avgRating,
              );
            },
          ),
      ],
    );
  }
}
