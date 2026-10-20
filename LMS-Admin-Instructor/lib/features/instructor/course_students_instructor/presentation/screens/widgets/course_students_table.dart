import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/domain/entity/course_student_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_state.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class CourseStudentsTable extends StatefulWidget {
  final String slug;
  const CourseStudentsTable({super.key, required this.slug});

  @override
  State<CourseStudentsTable> createState() => _CourseStudentsTableState();
}

class _CourseStudentsTableState extends State<CourseStudentsTable> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CourseStudentsBloc>().add(
            GetCourseStudentsEvent(
              slug: widget.slug,
              page: 1,
              search: query,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.isMobile ? 20.r : 32.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.secondary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilterHeader(context),
          SizedBox(height: context.isMobile ? 16.h : 32.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final tableWidth = constraints.maxWidth > 800.w
                  ? constraints.maxWidth
                  : 800.w;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: tableWidth,
                  child: Column(
                    children: [
                      _buildTableHeader(context),
                      const Divider(height: 1),
                      BlocBuilder<CourseStudentsBloc, CourseStudentsState>(
                        builder: (context, state) {
                          if (state is CourseStudentsLoading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 48),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is CourseStudentsError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 48,
                                ),
                                child: Text(state.message),
                              ),
                            );
                          } else if (state is CourseStudentsLoaded) {
                            final students = state.studentsListUIModel.students;
                            if (students.isEmpty) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 48),
                                  child: Text("No students found"),
                                ),
                              );
                            }
                            return Column(
                              children: [
                                ...students.map(
                                  (s) => _buildStudentRow(context, s),
                                ),
                                if (state.isPaginationLoading)
                                  const Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16.w,
        runSpacing: 16.h,
        children: [
          Text(
            context.tr('students_enrolled'),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomTextFormField(
            w: context.isMobile ? double.infinity : 300.w,
            txt: '',
            hint: context.tr('search_students_hint'),
            prefixIcon: Icons.search,
            controller: _searchController,
            suffixIcon: _searchController.text.isNotEmpty ? Icons.clear : null,
            onSuffixIcon: () {
              _searchController.clear();
              _onSearchChanged('');
              setState(() {});
            },
            onChanged: (value) {
              _onSearchChanged(value);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              context.tr('student_name'),
              style: _headerStyle(context),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              context.tr('enrollment_date'),
              style: _headerStyle(context),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              context.tr('progress'),
              style: _headerStyle(context),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              context.tr('action'),
              style: _headerStyle(context),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle? _headerStyle(BuildContext context) =>
      context.textTheme.labelMedium?.copyWith(
        color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        fontWeight: FontWeight.bold,
      );

  Widget _buildStudentRow(
    BuildContext context,
    CourseStudentItemUIModel student,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: context.colorScheme.primaryContainer,
                  child: Text(
                    student.name[0],
                    style: TextStyle(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        student.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              student.enrollmentDate,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: student.progress,
                      backgroundColor:
                          context.colorScheme.surfaceContainerHighest,
                      color: _getProgressColor(context, student.progress),
                      minHeight: 8.h,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  '${(student.progress * 100).toInt()}%',
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: IconButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.studentDetails,
                    extra: student.slug,
                  );
                },
                icon: Icon(
                  Icons.visibility_outlined,
                  color: context.colorScheme.primary,
                  size: 20.sp,
                ),
                tooltip: context.tr('view_profile'),
              ),
            ),

          ),
        ],
      ),
    );
  }

  Color _getProgressColor(BuildContext context, double progress) {
    if (progress > 0.8) return context.colorScheme.secondary;
    if (progress > 0.4) return context.colorScheme.primary;
    return Colors.orange;
  }
}
