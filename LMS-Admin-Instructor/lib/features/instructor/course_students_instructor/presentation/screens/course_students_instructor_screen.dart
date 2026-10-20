import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/screens/widgets/course_students_header.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/screens/widgets/course_students_stats.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/screens/widgets/course_students_table.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_state.dart';

class CourseStudentsInstructorScreen extends StatefulWidget {
  final String slug;
  const CourseStudentsInstructorScreen({super.key, required this.slug});

  @override
  State<CourseStudentsInstructorScreen> createState() =>
      _CourseStudentsInstructorScreenState();
}

class _CourseStudentsInstructorScreenState
    extends State<CourseStudentsInstructorScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final bloc = context.read<CourseStudentsBloc>();
      final state = bloc.state;
      if (state is CourseStudentsLoaded && !state.isPaginationLoading) {
        if (state.studentsListUIModel.currentPage <
            state.studentsListUIModel.totalPages) {
          bloc.add(
            GetCourseStudentsEvent(
              slug: widget.slug,
              page: state.studentsListUIModel.currentPage + 1,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: context.isDesktop ? 60.w : 20.w,
          vertical: 40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseStudentsHeader(slug: widget.slug),
            SizedBox(height: context.isMobile ? 24.h : 40.h),
            const CourseStudentsStats(),
            SizedBox(height: context.isMobile ? 24.h : 48.h),
            CourseStudentsTable(slug: widget.slug),
          ],
        ),
      ),
    );
  }
}
