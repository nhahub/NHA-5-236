import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/students/screens/students_list/bloc/student_bloc.dart';
import 'package:lms_admin_instructor/features/students/screens/students_list/bloc/student_event.dart';
import 'package:lms_admin_instructor/features/students/screens/students_list/bloc/student_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_desktop.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_nav_bar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<StudentBloc>().add(GetStudentsEvent(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<StudentBloc>().state;
      if (state is StudentLoaded && !state.isPaginationLoading) {
        context.read<StudentBloc>().add(
          GetStudentsEvent(page: state.studentUIModel.currentPage + 1),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<StudentBloc>().add(GetStudentsEvent(page: 1, search: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.005),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomNavBar(
          hint: context.tr('search_by_name'),
          controller: _searchController,
          onSearch: _onSearchChanged,
        ),
        toolbarHeight: 70.h,
      ),
      body: Padding(
        padding: EdgeInsets.all(40.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr('manage_students'),
              style: context.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            Text(
              context.tr("create_update_manage_student_profiles_assignments"),
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 32.h),
            BlocBuilder<StudentBloc, StudentState>(
              buildWhen: (previous, current) => current is StudentLoaded,
              builder: (context, state) {
                return Wrap(
                  spacing: 16.w,
                  runSpacing: 16.h,
                  children: [
                    CustomCardStatusInfoDesktop(
                      title: context.tr('total_enrollments'),
                      value: state is StudentLoaded
                          ? state.studentUIModel.totalEnrollments.toString()
                          : '??',
                      icon: Icons.assignment_outlined,
                      color: context.colorScheme.primary,
                    ),
                    CustomCardStatusInfoDesktop(
                      title: context.tr('total_students'),
                      value: state is StudentLoaded
                          ? state.studentUIModel.totalStudents.toString()
                          : '??',
                      icon: Icons.people_outline,
                      color: context.colorScheme.primary,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: BlocBuilder<StudentBloc, StudentState>(
                builder: (context, state) {
                  if (state is StudentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StudentError) {
                    return Center(child: Text(state.message));
                  } else if (state is StudentLoaded) {
                    return CustomDataTable(
                      headers: [
                        context.tr('student_name'),
                        context.tr('email_label'),
                        context.tr('status'),
                      ],
                      columnFlex: const [3, 4, 2],
                      data: state.studentUIModel.students
                          .map((student) {
                            return student.copyWith(
                              onActionPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return CustomDeleteDialog(
                                      title: context.tr('delete_student_title'),
                                      warningMessage: context.tr(
                                        'delete_student_warning_message',
                                      ),
                                      consequencesMessage: context.tr(
                                        'delete_student_consequences',
                                      ),
                                      onDelete: () {
                                        context.read<StudentBloc>().add(
                                          DeleteStudentEvent(
                                            slug: student.slug,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              onOptionsPressed: () {
                                context.pushNamed(
                                  AppRoutes.studentDetails,
                                  extra: student.slug,
                                );
                              },
                            );
                          })
                          .cast<CustomDataTableRowModel>()
                          .toList(),
                      scrollController: _scrollController,
                      isPaginationLoading: state.isPaginationLoading,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
