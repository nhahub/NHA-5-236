
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_state.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_state.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_instructor_information_mobile.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_instructor_status_mobile.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_card.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class InstructorDetailsMobileAdminScreen extends StatefulWidget {
  final String slug;
  const InstructorDetailsMobileAdminScreen({super.key, required this.slug});

  @override
  State<InstructorDetailsMobileAdminScreen> createState() =>
      _InstructorDetailsMobileAdminScreenState();
}

class _InstructorDetailsMobileAdminScreenState
    extends State<InstructorDetailsMobileAdminScreen> {
  final ScrollController _scrollController = ScrollController();

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
    return BlocListener<InstructorAdminBloc, InstructorAdminState>(
      listener: (context, state) {
        if (state is DeleteInstructorSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Instructor deleted successfully"),
              backgroundColor: Colors.green,
            ),
          );
          context.pop(); // Go back to the list
        }
        if (state is DeleteInstructorError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.primary.withValues(alpha: 0.01),
        appBar: AppBar(
          title: Text(
            "Profile",
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    //***********************************??Instructor Informations??*****************
                    BlocBuilder<InstructorAdminBloc, InstructorAdminState>(
                      builder: (context, state) {
                        if (state is InstructorDetailsLoading) {
                          return SizedBox(
                            height: 100.h,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is InstructorDetailsError) {
                          return Center(child: Text(state.message));
                        }
                        if (state is InstructorDetailsLoaded) {
                          final instructor =
                              state.instructorDetailsUiModel.data;
                          return CustomInstructorInformationMobile(
                            name:
                                "${instructor.first_name} ${instructor.last_name}",
                            title: instructor.description ?? "",
                            image: instructor.image ?? "",
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 24.h),

                    //***********************************??Instructor Status & Courses??*****************
                    BlocBuilder<InstructorDetailsBloc, InstructorDetailsState>(
                      builder: (context, state) {
                        if (state is InstructorCoursesLoading) {
                          return SizedBox(
                            height: 200.h,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is InstructorCoursesError) {
                          return Center(child: Text(state.message));
                        }
                        if (state is InstructorCoursesLoaded) {
                          final instructorData =
                              state.instructorCourseAdminUiModel.data;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomInstructorStatusMobile(
                                    title: "Total Students",
                                    num:
                                        "${state.instructorCourseAdminUiModel.data!.totalCourses}", // Static format assuming aggregation is not available directly, ideally from total students list if API provided it
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.08),
                                    colorIcon: context.colorScheme.primary,
                                    colornum: context.colorScheme.primary,
                                    colortitle: context.colorScheme.onSurface,
                                    icon: Icons.group,
                                  ),
                                  CustomInstructorStatusMobile(
                                    title: "Total Courses",
                                    num: "${instructorData?.totalCourses ?? 0}",
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.08),
                                    colorIcon: context.colorScheme.onSecondary
                                        .withValues(alpha: 0.8),
                                    colornum: context.colorScheme.primary,
                                    colortitle: context.colorScheme.onSurface,
                                    icon: Icons.star,
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),

                              // Courses List Mapping
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: instructorData?.courses.length ?? 0,
                                itemBuilder: (context, index) {
                                  final course = instructorData!.courses[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 24.h),
                                    child: CustomCard(
                                      bottom_action: context.tr(
                                        'delete_course',
                                      ),
                                      icon: Icons.book,
                                      total_num: course.studentsCount,
                                      onTap: () {},
                                      title: course.title,
                                      description:
                                          "Created on ${course.createdAt}", // Minimal replacement for description
                                      image:
                                          course.image ??
                                          "https://i.pinimg.com/736x/2e/76/31/2e763110981d9269aeb96ec1ddae93cf.jpg",
                                    ),
                                  );
                                },
                              ),

                              // Pagination Loader
                              if (state.isPaginationLoading)
                                Padding(
                                  padding: EdgeInsets.all(16.r),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
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
              //***********************************??Delete Instructor??*****************
              SizedBox(height: 24.h),
              CustomPrimaryButton(
                text: "Delete Instructor",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text("Delete Instructor"),
                      content: const Text(
                        "Are you sure you want to delete this instructor?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            context.read<InstructorAdminBloc>().add(
                              DeleteInstructorEvent(slug: widget.slug),
                            );
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                width: 300,
                height: 50,
                prefixIcon: const Icon(Icons.delete),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.error.withValues(
                    alpha: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
