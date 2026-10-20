import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_event.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_event.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_state.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_material_section/custom_course_sidebar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';
import 'package:lms_admin_instructor/features/widgets/error_feedback_widget.dart';
import 'package:lms_admin_instructor/features/widgets/loading_indicator_widget.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/screens/widgets/upload_material_dialog.dart';

class CourseMaterialSection extends StatefulWidget {
  final String slug;
  final String courseName;
  const CourseMaterialSection({
    super.key,
    required this.slug,
    required this.courseName,
  });

  @override
  State<CourseMaterialSection> createState() => _CourseMaterialSectionState();
}

class _CourseMaterialSectionState extends State<CourseMaterialSection> {
  @override
  void initState() {
    super.initState();
    context.read<CourseMaterialsBloc>().add(
      GetCourseMaterialsEvent(slug: widget.slug, pageSize: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseMaterialsBloc, CourseMaterialsState>(
      listener: (context, state) {
        if (state is DeleteMaterialSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          _refreshData();
        } else if (state is DeleteMaterialError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<CourseMaterialsBloc, CourseMaterialsState>(
        builder: (context, state) {
          if (state is CourseMaterialsLoading) {
            return const LoadingIndicatorWidget();
          }

          if (state is CourseMaterialsError) {
            return ErrorFeedbackWidget(
              errorMessage: state.message,
              onRetry: () {
                context.read<CourseMaterialsBloc>().add(
                  GetCourseMaterialsEvent(slug: widget.slug, pageSize: 4),
                );
              },
            );
          }

          if (state is CourseMaterialsLoaded) {
            final materials = state.materialsListUIModel.materials;

            return CustomCourseSidebar(
              title: context.tr('course_materials'),
              icon: Icons.folder_outlined,
              color: context.colorScheme.primary,
              onManage: () {
                context.pushNamed(
                  AppRoutes.courseMaterials,
                  pathParameters: {'slug': widget.slug},
                  extra: widget.courseName,
                );
              },
              manageText: context.tr('show_more'),
              children: [
                if (materials.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(
                      child: Text(
                        context.tr('no_materials_found'),
                        style: context.textTheme.labelMedium,
                      ),
                    ),
                  )
                else
                  ...materials.map(
                    (material) => _buildMaterialItem(context, material),
                  ),
                _buildUploadButton(context, context.tr("add_material")),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    CourseMaterialItemUIModel material,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => CustomDeleteDialog(
        title: context.tr('delete_material'),
        warningMessage: context.tr('delete_student_warning_message'),
        consequencesMessage: context.tr('are_you_sure_delete_material'),
        onDelete: () {
          context.read<CourseMaterialsBloc>().add(
            DeleteMaterialEvent(
              courseSlug: widget.slug,
              materialSlug: material.slug,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMaterialItem(
    BuildContext context,
    CourseMaterialItemUIModel material,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (material.file != null) {
                  context.pushNamed(
                    AppRoutes.pdfViewer,
                    extra: {
                      'url': material.file,
                      'title': material.materialName,
                    },
                  );
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    size: 20.sp,
                    color: context.colorScheme.secondary,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          material.materialName,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          material.fileSize ?? '',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context, material),
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
        final bloc = context.read<CourseMaterialsBloc>();
        final result = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => BlocProvider.value(
            value: bloc,
            child: UploadMaterialDialog(courseSlug: widget.slug),
          ),
        );
        if (result == true && context.mounted) {
          _refreshData();
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

  void _refreshData() {
    context.read<CourseDetailsBloc>().add(
      GetCourseDetailsEvent(slug: widget.slug),
    );
    context.read<CourseStatsBloc>().add(GetCourseStatsEvent(slug: widget.slug));
    context.read<CourseMaterialsBloc>().add(
      GetCourseMaterialsEvent(slug: widget.slug, page: 1, pageSize: 4),
    );
  }
}
