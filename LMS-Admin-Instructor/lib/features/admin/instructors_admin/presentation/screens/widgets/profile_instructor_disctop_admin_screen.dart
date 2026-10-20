import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_state.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_state.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_instructor_information_disktop.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/stats_card_widget .dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';
import 'package:lms_admin_instructor/features/widgets/search_bar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';

class InstructorDetailsDisktopAdminScreen extends StatefulWidget {
  final String slug;
  const InstructorDetailsDisktopAdminScreen({super.key, required this.slug});

  @override
  State<InstructorDetailsDisktopAdminScreen> createState() =>
      _InstructorDetailsDisktopAdminScreenState();
}

class _InstructorDetailsDisktopAdminScreenState
    extends State<InstructorDetailsDisktopAdminScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<InstructorAdminBloc>().add(
      GetInstructorBySlugEvent(slug: widget.slug),
    );
    context.read<InstructorDetailsBloc>().add(
      GetInstructorCoursesEvent(slug: widget.slug, page: 1),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<InstructorDetailsBloc>().state;
      if (state is InstructorCoursesLoaded && !state.isPaginationLoading) {
        final data = state.instructorCourseAdminUiModel.data;
        if (data != null && data.currentPage < data.totalPages) {
          context.read<InstructorDetailsBloc>().add(
            GetInstructorCoursesEvent(
              slug: widget.slug,
              page: data.currentPage + 1,
              search: _searchController.text,
            ),
          );
        }
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<InstructorDetailsBloc>().add(
        GetInstructorCoursesEvent(slug: widget.slug, page: 1, search: query),
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
    return BlocListener<InstructorAdminBloc, InstructorAdminState>(
      listener: (context, state) {
        if (state is DeleteInstructorSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Instructor deleted successfully"),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.pop();
        }
        if (state is DeleteInstructorError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Profile Instructor")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //***********************************??Instructor Informations??*****************
              BlocBuilder<InstructorAdminBloc, InstructorAdminState>(
                builder: (context, state) {
                  if (state is InstructorDetailsLoading ||
                      state is DeleteInstructorLoading) {
                    return SizedBox(
                      height: 150.h,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is InstructorDetailsError) {
                    log(state.message);
                    return Center(child: Text(state.message));
                  }
                  if (state is InstructorDetailsLoaded) {
                    final instructor = state.instructorDetailsUiModel.data;
                    return CustomInstructorInformationDisktop(
                      name: "${instructor.first_name} ${instructor.last_name}",
                      description: instructor.description ?? "",
                      image: instructor.image ?? "",
                      slug: widget.slug,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 32.h),

              BlocBuilder<InstructorDetailsBloc, InstructorDetailsState>(
                builder: (context, state) {
                  if (state is InstructorCoursesLoading) {
                    return SizedBox(
                      height: 150.h,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is InstructorCoursesError) {
                    log(state.message);
                    return Center(child: Text(state.message));
                  }
                  if (state is InstructorCoursesLoaded) {
                    final instructor = state.instructorCourseAdminUiModel.data;
                    return Column(
                      children: [
                        //***********************************??Instructor Stats??*****************
                        Row(
                          children: [
                            StatsCardWidget(
                              backGroundIconColor: context.colorScheme.primary
                                  .withValues(alpha: 0.1),
                              title: "Total Students",
                              value:
                                  "${state.instructorCourseAdminUiModel.data!.totalCourses}",
                              icon: Icons.people_alt_rounded,
                              iconColor: context.colorScheme.primary,
                            ),
                            // SizedBox(width: 24.w),
                            // StatsCardWidget(
                            //   title: "Avg. Total Course Rating",
                            //   value: "4.9",
                            //   icon: Icons.star_border_outlined,
                            //   iconColor: Colors.amber,
                            //   backGroundIconColor: Colors.amber.withValues(
                            //     alpha: 0.1,
                            //   ),
                            //   subtitle: "/5",
                            //   footerText: "Based on 3,420 reviews",
                            // ),
                          ],
                        ),

                        SizedBox(height: 30.h),

                        //***********************************??Assigned Courses??*****************
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Assigned Courses",
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            CustomSearchBarr(
                              hint: context.tr('search_courses_hint'),
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              onFieldSubmitted: _onSearchChanged,
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        SizedBox(
                          height: 400.h,
                          child: CustomDataTable(
                            headers: [
                              context.tr('course_name'),
                              context.tr('students_enrolled'),
                              context.tr('rating'),
                              context.tr('created_date'),
                            ],
                            data:
                                instructor?.courses
                                    .map((course) {
                                      return course.copyWith(
                                        onActionPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return CustomDeleteDialog(
                                                title: context.tr(
                                                  'delete_course_title',
                                                ),
                                                warningMessage: context.tr(
                                                  'delete_course_warning_message',
                                                ),
                                                consequencesMessage: context.tr(
                                                  'delete_course_consequences',
                                                ),
                                                onDelete: () {
                                                  // TODO delete course
                                                  // context
                                                  //     .read<
                                                  //       InstructorDetailsBloc
                                                  //     >()
                                                  //     .add(
                                                  //       DeleteInstructorCourseEvent(
                                                  //         courseSlug:
                                                  //             course.slug,
                                                  //       ),
                                                  //     );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        actionIconpressed: Icons.delete,
                                        optionsIconpressed:
                                            Icons.arrow_forward_ios_rounded,
                                        onOptionsPressed: () {
                                          context.pushNamed(
                                            AppRoutes.courseDetails,
                                            pathParameters: {
                                              'slug': course.slug,
                                            },
                                          );
                                        },
                                      );
                                    })
                                    .cast<CustomDataTableRowModel>()
                                    .toList() ??
                                [],
                            columnFlex: const [3, 2, 2, 2],
                            scrollController: _scrollController,
                            isPaginationLoading: state.isPaginationLoading,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
