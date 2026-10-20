import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_state.dart';
import 'package:lms_admin_instructor/features/widgets/error_feedback_widget.dart';
import 'package:lms_admin_instructor/features/widgets/loading_indicator_widget.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_material_section/custom_course_sidebar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';

class CourseQuizSection extends StatefulWidget {
  final String courseSlug;
  const CourseQuizSection({super.key, required this.courseSlug});

  @override
  State<CourseQuizSection> createState() => _CourseQuizSectionState();
}

class _CourseQuizSectionState extends State<CourseQuizSection> {
  @override
  void initState() {
    super.initState();
    context.read<CourseQuizBloc>().add(
      GetQuizzesForCourseEvent(courseSlug: widget.courseSlug, pageSize: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseQuizBloc, CourseQuizState>(
      listener: (context, state) {
        if (state is DeleteQuizSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.tr('quiz_deleted_success'))),
          );
          context.read<CourseQuizBloc>().add(
            GetQuizzesForCourseEvent(
              courseSlug: widget.courseSlug,
              pageSize: 4,
            ),
          );
        } else if (state is DeleteQuizError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<CourseQuizBloc, CourseQuizState>(
        builder: (context, state) {
          if (state is CourseQuizLoading) {
            return const LoadingIndicatorWidget();
          }

          if (state is CourseQuizError) {
            return ErrorFeedbackWidget(
              errorMessage: state.message,
              onRetry: () {
                context.read<CourseQuizBloc>().add(
                  GetQuizzesForCourseEvent(courseSlug: widget.courseSlug),
                );
              },
            );
          }

          if (state is CourseQuizLoaded) {
            final quizzes = state.uiModel?.quizzes ?? [];
            final hasMore =
                (state.uiModel?.currentPage ?? 1) <
                (state.uiModel?.totalPages ?? 1);

            return CustomCourseSidebar(
              title: context.tr('quizzes'),
              icon: Icons.quiz,
              color: Colors.purple,
              children: [
                ...quizzes.map(
                  (quiz) => _buildQuizItem(
                    context,
                    quiz.quizName,
                    "${quiz.totalMark} ${context.tr('marks')}",
                    quiz.slug,
                  ),
                ),
                if (hasMore)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Center(
                      child: TextButton(
                        onPressed: state.isPaginationLoading
                            ? null
                            : () {
                                context.read<CourseQuizBloc>().add(
                                  GetQuizzesForCourseEvent(
                                    courseSlug: widget.courseSlug,
                                    page: (state.uiModel?.currentPage ?? 1) + 1,
                                    pageSize: 4,
                                  ),
                                );
                              },
                        child: state.isPaginationLoading
                            ? SizedBox(
                                height: 16.h,
                                width: 16.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.w,
                                  color: context.colorScheme.primary,
                                ),
                              )
                            : Text(
                                context.tr("show_more"),
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                _buildUploadButton(context, context.tr("add_quiz")),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String? slug) {
    if (slug == null) return;

    showDialog(
      context: context,
      builder: (dialogContext) => CustomDeleteDialog(
        title: context.tr('delete_quiz'),
        warningMessage: context.tr('delete_student_warning_message'),
        consequencesMessage: context.tr('are_you_sure_delete_quiz'),
        onDelete: () {
          context.read<CourseQuizBloc>().add(
            DeleteQuizEvent(courseSlug: widget.courseSlug, quizSlug: slug),
          );
        },
      ),
    );
  }

  Widget _buildQuizItem(
    BuildContext context,
    String title,
    String subtitle,
    String? slug,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                final result = await context.pushNamed(
                  AppRoutes.manageQuizScreen,
                  pathParameters: {'slug': widget.courseSlug},
                  queryParameters: {'quizSlug': slug ?? ''},
                );
                if (result == true && context.mounted) {
                  context.read<CourseQuizBloc>().add(
                    GetQuizzesForCourseEvent(
                      courseSlug: widget.courseSlug,
                      pageSize: 4,
                    ),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: 12.sp,
                        color: context.colorScheme.outline,
                      ),
                      SizedBox(width: 4.w),
                      Text(subtitle, style: context.textTheme.labelSmall),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context, slug),
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

  Widget _buildUploadButton(BuildContext context, String text) {
    return CustomPrimaryButton(
      onTap: () async {
        await context.pushNamed(
          AppRoutes.manageQuizScreen,
          pathParameters: {"slug": widget.courseSlug},
        );
        if (context.mounted) {
          context.read<CourseQuizBloc>().add(
            GetQuizzesForCourseEvent(
              courseSlug: widget.courseSlug,
              pageSize: 4,
            ),
          );
        }
      },
      text: text,
      prefixIcon: Icon(
        Icons.add,
        size: 18.sp,
        color: context.colorScheme.primary,
      ),
      width: double.infinity,
      height: 45.h,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: BorderSide(color: context.colorScheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      textStyle: context.textTheme.labelMedium?.copyWith(
        color: context.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
