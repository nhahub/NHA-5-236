import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/students/data/model/student_details_model.dart';
import 'package:lms_admin_instructor/features/students/screens/student_details/bloc/student_details_bloc.dart';
import 'package:lms_admin_instructor/features/students/screens/student_details/screens/widgets/student_course_card.dart';
import 'package:lms_admin_instructor/features/widgets/loading_indicator_widget.dart';

class StudentDetailsScreen extends StatefulWidget {
  final String slug;
  const StudentDetailsScreen({super.key, required this.slug});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentDetailsBloc>().add(GetStudentDetailsData(widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.isDesktop;

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        title: Text(context.tr('student_details')),
        centerTitle: false,
      ),
      body: BlocBuilder<StudentDetailsBloc, StudentDetailsState>(
        builder: (context, state) {
          if (state is StudentDetailsStateLoading) {
            return const Center(child: LoadingIndicatorWidget());
          } else if (state is StudentDetailsStateError) {
            return Center(child: Text(state.message));
          } else if (state is StudentDetailsStateSuccess) {
            final student = state.studentDetails.data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 40.r : 16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, student, isDesktop),
                    SizedBox(height: 32.h),
                    _buildStatsSection(context, student, isDesktop),
                    SizedBox(height: 40.h),
                    Text(
                      context.tr('courses_enrolled'),
                      style: context.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildCoursesGrid(context, student.courses, isDesktop),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    StudentDetailsDataModel student,
    bool isDesktop,
  ) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 32.r : 20.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isDesktop ? 50.r : 35.r,
            backgroundColor: context.colorScheme.primary.withValues(alpha: 0.1),
            backgroundImage: student.image != null
                ? NetworkImage(student.image!)
                : null,
            child: student.image == null
                ? Text(
                    student.name.isNotEmpty
                        ? student.name[0].toUpperCase()
                        : '?',
                    style:
                        (isDesktop
                                ? context.textTheme.headlineLarge
                                : context.textTheme.headlineSmall)!
                            .copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                  )
                : null,
          ),
          SizedBox(width: isDesktop ? 32.w : 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style:
                      (isDesktop
                              ? context.textTheme.headlineMedium
                              : context.textTheme.titleLarge)!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                ),
                SizedBox(height: 4.h),
                Text(
                  student.email,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context,
    StudentDetailsDataModel student,
    bool isDesktop,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            context.tr('total_enrollments'),
            student.totalEnrollments.toString(),
            Icons.book_outlined,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildStatCard(
            context,
            context.tr('average_score'),
            student.averageScore.toStringAsFixed(1),
            Icons.star_outline,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.colorScheme.primary, size: 24.sp),
          SizedBox(height: 16.h),
          Text(
            title,
            style: context.textTheme.labelMedium!.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: context.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesGrid(
    BuildContext context,
    List<StudentDetailsCourseModel> courses,
    bool isDesktop,
  ) {
    if (courses.isEmpty) {
      return Center(
        child: Text(
          context.tr('no_courses_enrolled'),
          style: context.textTheme.bodyMedium!.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
        mainAxisExtent: 180.h,
      ),
      itemBuilder: (context, index) {
        return StudentCourseCard(course: courses[index]);
      },
    );
  }
}
