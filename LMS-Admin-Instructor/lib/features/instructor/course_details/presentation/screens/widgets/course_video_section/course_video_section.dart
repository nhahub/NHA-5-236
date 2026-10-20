import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/presentation/bloc/add_new_video_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/presentation/bloc/add_new_video_state.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/video_model/course_video_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_video_bloc/course_video_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_video_bloc/course_video_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_video_bloc/course_video_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/presentation/screens/add_new_video_screen.dart';
import 'package:lms_admin_instructor/features/widgets/error_feedback_widget.dart';
import 'package:lms_admin_instructor/features/widgets/loading_indicator_widget.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';
import 'package:lms_admin_instructor/features/widgets/snack_bar_widget.dart';

class CourseVideoSection extends StatelessWidget {
  final String slug;
  const CourseVideoSection({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    log('CourseVideoSection: Passing slug to Bloc -> $slug');
    return BlocProvider(
      create: (context) =>
          sl<CourseVideoBloc>()..add(GetCourseVideosEvent(courseSlug: slug)),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddNewVideoBloc, AddNewVideoState>(
            listener: (context, state) {
              if (state is AddNewVideoSuccess) {
                context.read<CourseVideoBloc>().add(
                      GetCourseVideosEvent(courseSlug: slug),
                    );
              }
            },
          ),
          BlocListener<CourseVideoBloc, CourseVideoState>(
            listener: (context, state) {
              if (state is DeleteVideoSuccess) {
                showCustomSnackBar(
                  context,
                  message: state.message,
                  backgroundColor: Colors.green,
                  icon: Icons.check_circle,
                );
              } else if (state is DeleteVideoError) {
                showCustomSnackBar(
                  context,
                  message: state.message,
                  backgroundColor: context.colorScheme.error,
                  icon: Icons.error,
                );
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AddNewVideoBloc, AddNewVideoState>(
              builder: (context, state) {
                if ((state is AddNewVideoLoading ||
                        state is AddNewVideoProgress) &&
                    state is! AddNewVideoInitial) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.r,
                          height: 16.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          context.tr('adding_video'),
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Builder(builder: (context) => _buildHeader(context)),
            SizedBox(height: 16.h),
            Builder(
              builder: (context) => Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: context.colorScheme.outline.withValues(alpha: 0.5),
                  ),
                ),
                child: BlocBuilder<CourseVideoBloc, CourseVideoState>(
                  builder: (context, state) {
                    if (state is CourseVideoLoading) {
                      return Padding(
                        padding: EdgeInsets.all(32.r),
                        child: const Center(child: LoadingIndicatorWidget()),
                      );
                    } else if (state is CourseVideoError) {
                      return _buildEmptyOrError(context, state.message);
                    } else if (state is CourseVideoLoaded) {
                      if (state.videos.isEmpty) {
                        return _buildEmptyOrError(
                          context,
                          context.tr('no_videos_found'),
                        );
                      }
                      return _buildLoadedVideos(context, state.videos);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Builder(
              builder: (context) => _buildAddNewButton(
                context,
                context.tr('add_new_video'),
                Icons.add_circle_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return context.isDesktop
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderTitle(context),
              // _buildHeaderActions(context),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderTitle(context),
              // SizedBox(height: 8.h),
              // _buildHeaderActions(context),
            ],
          );
  }

  Widget _buildEmptyOrError(BuildContext context, String message) {
    return Column(
      children: [
        _buildSectionItem(
          context,
          context.tr('section_all_videos'),
          '0 ${context.tr('video_placeholder')}',
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: ErrorFeedbackWidget(errorMessage: message),
        ),
      ],
    );
  }

  Widget _buildLoadedVideos(
    BuildContext context,
    List<CourseVideoModel> videos,
  ) {
    return _buildCategorySection(
      context,
      context.tr('section_all_videos'),
      videos,
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String categoryName,
    List<CourseVideoModel> videos,
  ) {
    return Column(
      children: [
        _buildSectionItem(
          context,
          categoryName,
          '${videos.length} ${context.tr('video_placeholder')}',
        ),
        ...videos.asMap().entries.map((entry) {
          final index = entry.key;
          final video = entry.value;
          return _buildSubsectionItem(context, video, index: index);
        }),
      ],
    );
  }

  Widget _buildHeaderTitle(BuildContext context) {
    return Text(
      context.tr('course_structure'),
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Widget _buildHeaderActions(BuildContext context) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       TextButton(
  //         onPressed: () {},
  //         child: Text(
  //           context.tr('expand_all'),
  //           style: TextStyle(fontSize: 12.sp),
  //         ),
  //       ),
  //       const Text("|"),
  //       TextButton(
  //         onPressed: () {},
  //         child: Text(
  //           context.tr('collapse_all'),
  //           style: TextStyle(fontSize: 12.sp),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSectionItem(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.video_call, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: context.isDesktop ? null : 14.sp,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: context.isDesktop ? null : 10.sp,
                  ),
                ),
              ],
            ),
          ),
          // Icon(
          //   Icons.edit_outlined,
          //   size: 18.sp,
          //   color: context.colorScheme.outline,
          // ),
          // SizedBox(width: 12.w),
          // Icon(
          //   Icons.delete_outline,
          //   size: 18.sp,
          //   color: context.colorScheme.outline,
          // ),
        ],
      ),
    );
  }

  Widget _buildSubsectionItem(
    BuildContext context,
    CourseVideoModel video, {
    required int index,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.isDesktop ? 48.w : 24.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                color: context.colorScheme.primary,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.video_library_outlined,
                      size: 12.sp,
                      color: context.colorScheme.outline,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "${context.tr('video_placeholder')} • ${video.duration ?? '00:00'}",
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => CustomDeleteDialog(
                  title: context.tr('delete_video'),
                  warningMessage: context.tr('delete_video_warning'),
                  consequencesMessage: context.tr('delete_video_consequences'),
                  onDelete: () {
                    context.read<CourseVideoBloc>().add(
                          DeleteVideoEvent(
                              videoSlug: video.slug, courseSlug: slug),
                        );
                  },
                ),
              );
            },
            icon: Icon(
              Icons.delete_outline,
              color: context.colorScheme.error,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewButton(BuildContext context, String text, IconData icon) {
    return CustomPrimaryButton(
      onTap: () async {
        final addNewVideoBloc = context.read<AddNewVideoBloc>();
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => BlocProvider.value(
            value: addNewVideoBloc,
            child: AddNewVideoScreen(courseSlug: slug),
          ),
        );
        if (result == true && context.mounted) {
          context.read<CourseVideoBloc>().add(
                GetCourseVideosEvent(courseSlug: slug),
              );
        }
      },
      text: text,
      prefixIcon: Icon(icon, size: 20.sp, color: context.colorScheme.primary),
      width: double.infinity,
      height: 50.h,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: BorderSide(color: context.colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      textStyle: context.textTheme.labelLarge?.copyWith(
        color: context.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
