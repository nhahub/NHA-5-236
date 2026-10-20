import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/bloc/all_courses_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/bloc/all_courses_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/bloc/all_courses_admin_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_desktop.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_nav_bar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';

class AllCoursesAdminDesktopScreen extends StatefulWidget {
  const AllCoursesAdminDesktopScreen({super.key});

  @override
  State<AllCoursesAdminDesktopScreen> createState() =>
      _AllCoursesAdminDesktopScreenState();
}

class _AllCoursesAdminDesktopScreenState
    extends State<AllCoursesAdminDesktopScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<AllCoursesAdminBloc>().state;
      if (state is AllCoursesAdminLoaded && !state.isPaginationLoading) {
        if (state.courseListUIModel.currentPage <
            state.courseListUIModel.totalPages) {
          context.read<AllCoursesAdminBloc>().add(
            GetAllCoursesAdminEvent(
              page: state.courseListUIModel.currentPage + 1,
              search: _searchController.text,
            ),
          );
        }
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<AllCoursesAdminBloc>().add(
        GetAllCoursesAdminEvent(page: 1, search: query),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.005),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomNavBar(
          hint: context.tr('search_courses_hint'),
          onSearch: _onSearchChanged,
          controller: _searchController,
        ),
        toolbarHeight: 70.h,
      ),
      body: BlocListener<AllCoursesAdminBloc, AllCoursesAdminState>(
        listener: (context, state) {
          if (state is DeleteCourseAdminSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.read<AllCoursesAdminBloc>().add(
              GetAllCoursesAdminEvent(
                page: 1,
                search: _searchController.text,
              ),
            );
          } else if (state is DeleteCourseAdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: context.colorScheme.error,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(40.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('all_courses'),
                    style: context.textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    context.tr("courses_screen_subtitle"),
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              BlocBuilder<AllCoursesAdminBloc, AllCoursesAdminState>(
                buildWhen: (previous, current) =>
                    current is AllCoursesAdminLoaded ||
                    current is AllCoursesAdminLoading ||
                    current is AllCoursesAdminError,
                builder: (context, state) {
                  return Row(
                    children: [
                      CustomCardStatusInfoDesktop(
                        title: context.tr('total_courses'),
                        value: state is AllCoursesAdminLoaded
                            ? state.courseListUIModel.totalCourses.toString()
                            : '0',
                        icon: Icons.school_outlined,
                        color: context.colorScheme.primary,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: BlocBuilder<AllCoursesAdminBloc, AllCoursesAdminState>(
                  buildWhen: (previous, current) =>
                      current is AllCoursesAdminLoaded ||
                      current is AllCoursesAdminLoading ||
                      current is AllCoursesAdminError ||
                      current is DeleteCourseAdminLoading,
                  builder: (context, state) {
                    if (state is AllCoursesAdminLoading ||
                        state is DeleteCourseAdminLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AllCoursesAdminError) {
                      return Center(child: Text(state.message));
                    } else if (state is AllCoursesAdminLoaded) {
                      return CustomDataTable(
                        headers: [
                          context.tr('course_name'),
                          context.tr('students_enrolled'),
                          context.tr('rating'),
                          context.tr('created_date'),
                          context.tr('instructor_name'),
                        ],
                        columnFlex: const [3, 3, 2, 2, 3],
                        centeredColumns: const [1, 2],
                        data: state.courseListUIModel.courses.map((course) {
                          return course.copyWith(
                            onActionPressed: () {
                              showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return BlocProvider.value(
                                    value: context.read<AllCoursesAdminBloc>(),
                                    child: CustomDeleteDialog(
                                      title: context.tr('delete_course_title'),
                                      warningMessage: context.tr(
                                        'delete_course_warning_message',
                                      ),
                                      consequencesMessage: context.tr(
                                        'delete_course_consequences',
                                      ),
                                      onDelete: () {
                                        context.read<AllCoursesAdminBloc>().add(
                                          DeleteCourseAdminEvent(
                                            slug: course.slug,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            actionIconpressed: Icons.delete_outline,
                            onOptionsPressed: () {
                              context.pushNamed(
                                AppRoutes.courseStudents,
                                pathParameters: {'slug': course.slug},
                              );
                            },
                          );
                        }).toList(),
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
      ),
    );
  }
}
