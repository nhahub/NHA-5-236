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
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_mobile.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/instructor_card.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class InstructorMobileAdminScreen extends StatefulWidget {
  const InstructorMobileAdminScreen({super.key});

  @override
  State<InstructorMobileAdminScreen> createState() =>
      _InstructorMobileAdminScreenState();
}

class _InstructorMobileAdminScreenState
    extends State<InstructorMobileAdminScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<InstructorAdminBloc>().add(GetInstructorAdminEvent(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<InstructorAdminBloc>().state;
      if (state is InstructorAdminLoaded && !state.isPaginationLoading) {
        context.read<InstructorAdminBloc>().add(
          GetInstructorAdminEvent(
            page: state.instructorAdminUiModel.currentPage + 1,
          ),
        );
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
      //**************************************??AppBar??********************************************??
      appBar: AppBar(
        title: Text(
          context.tr('all_instructors'),
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: InkWell(
              onTap: () {},
              child: CustomImage(
                aspectRatio: 1,
                imagePath:
                    "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                width: 45,
                height: 45,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
        ],
      ),
      //**************************************?? ADD INSTRUCTORS CARDS??********************************************??
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colorScheme.onSecondary,

        onPressed: () {
          context.push(AppRoutes.addInstructorAdminScreen);
        },
        child: Icon(Icons.person_add_alt, color: context.colorScheme.surface),
      ),
      //**************************************?? BODY??********************************************??
      body: Padding(
        padding: EdgeInsets.only(top: 22.h, left: 22.w, right: 20.w),
        child: BlocListener<InstructorAdminBloc, InstructorAdminState>(
          listener: (context, state) {
            if (state is DeleteInstructorSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Instructor deleted successfully"),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<InstructorAdminBloc>().add(
                GetInstructorAdminEvent(page: 1),
              );
            }
            if (state is DeleteInstructorError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<InstructorAdminBloc, InstructorAdminState>(
            buildWhen: (previous, current) =>
                current is InstructorAdminLoaded ||
                current is InstructorAdminLoading ||
                current is InstructorAdminError,
            builder: (context, state) {
              if (state is InstructorAdminLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is InstructorAdminError) {
                return Center(child: Text(state.message));
              }
              if (state is InstructorAdminLoaded) {
                final instructor = state.instructorAdminUiModel.instructors;
                return ListView(
                  controller: _scrollController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //***************************************??HEADERr PAGE??********************************************??
                        Text(
                          context.tr('manage_instructors'),
                          style: context.textTheme.displayMedium?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          context.tr(
                            'create_update_manage_instructor_profiles_assignments',
                          ),
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.onSurface.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),

                        //**************************************??TOTAL VIDEOS AND TOTAL COURSES CARDS??********************************************??
                        Row(
                          children: [
                            CustomCardStatusInfoMobile(
                              colortitle: context.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                              colornum: context.colorScheme.surface,
                              colorIcon: context.colorScheme.surface.withValues(
                                alpha: 0.5,
                              ),
                              icon: Icons.person,
                              title: context.tr('total_instructors'),
                              num:
                                  "${state.instructorAdminUiModel.totalInstructors}",
                              color1: context.colorScheme.primary,
                              color2: const Color(0xFF117A8B),
                              color3: context.colorScheme.primary.withValues(
                                alpha: 0.6,
                              ),
                            ),
                            // SizedBox(width: 16.w),
                            // CustomCardStatusInfoMobile(
                            //   colortitle: context.colorScheme.onSecondary
                            //       .withValues(alpha: 0.7),
                            //   colornum: context.colorScheme.primary,
                            //   colorIcon: context.colorScheme.onSecondary,
                            //   icon: Icons.book_outlined,
                            //   title: context.tr('total_courses'),
                            //   num: "48",
                            //   color1: context.colorScheme.secondary,
                            //   color2: context.colorScheme.secondary.withValues(
                            //     alpha: 0.6,
                            //   ),
                            //   color3: context.colorScheme.surface,
                            // ),
                          ],
                        ),

                        //**************************************?? INSTRUCTORS CARDS??********************************************??
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: 342.w,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: CustomCard(
                                  onTap: () {
                                    log(
                                      state
                                          .instructorAdminUiModel
                                          .instructors[index]
                                          .slug,
                                    );
                                    context.push(
                                      AppRoutes.profileInstructorAdminScreen,
                                      extra: instructor[index].slug,
                                    );
                                  },
                                  onDelete: () {
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                        title: const Text("Delete Instructor"),
                                        content: const Text(
                                          "Are you sure you want to delete this instructor?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(dialogContext),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(dialogContext);
                                              context
                                                  .read<InstructorAdminBloc>()
                                                  .add(
                                                    DeleteInstructorEvent(
                                                      slug: instructor[index]
                                                          .slug,
                                                    ),
                                                  );
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  bottom_action: "Manage",
                                  title:
                                      "${instructor[index].first_name} ${instructor[index].last_name}",
                                  description:
                                      "${instructor[index].description}",
                                  image: "${instructor[index].image}",
                                  total_num: 12,
                                ),
                              );
                            },
                            itemCount: instructor.length,
                          ),
                        ),
                        if (state.isPaginationLoading)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
