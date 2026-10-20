import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_desktop.dart';

class CourseStatsRow extends StatelessWidget {
  const CourseStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomCardStatusInfoDesktop(
            title: context.tr('total_videos'),
            value: "24",
            icon: Icons.play_circle_outline,
            color: context.colorScheme.primary,
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: CustomCardStatusInfoDesktop(
            title: context.tr('total_quizzes'),
            value: "5",
            icon: Icons.assignment_outlined,
            color: Colors.purple,
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: CustomCardStatusInfoDesktop(
            title: context.tr('materials'),
            value: "12",
            icon: Icons.folder_open_outlined,
            color: Colors.orange,
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: CustomCardStatusInfoDesktop(
            title: context.tr('students_enrolled'),
            value: "1,240",
            icon: Icons.people_outline,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
