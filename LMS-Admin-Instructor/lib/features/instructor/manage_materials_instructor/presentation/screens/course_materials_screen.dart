import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_event.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_state.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/screens/widgets/upload_material_dialog.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/screens/widgets/material_card.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/screens/widgets/materials_empty_state.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/screens/widgets/materials_header.dart';

class CourseMaterialsScreen extends StatefulWidget {
  final String slug;
  final String courseName;
  const CourseMaterialsScreen({
    super.key,
    required this.slug,
    required this.courseName,
  });

  @override
  State<CourseMaterialsScreen> createState() => _CourseMaterialsScreenState();
}

class _CourseMaterialsScreenState extends State<CourseMaterialsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isChanged = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final bloc = context.read<CourseMaterialsBloc>();
      final state = bloc.state;
      if (state is CourseMaterialsLoaded && !state.isPaginationLoading) {
        if (state.materialsListUIModel.currentPage <
            state.materialsListUIModel.totalPages) {
          bloc.add(
            GetCourseMaterialsEvent(
              slug: widget.slug,
              page: state.materialsListUIModel.currentPage + 1,
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.pop(_isChanged);
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceContainerHighest,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 100.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: InkWell(
              onTap: () => context.pop(_isChanged),
              borderRadius: BorderRadius.circular(8.r),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    size: 16.sp,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    context.tr('back'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16.w),
              child: IconButton(
                onPressed: () => _showUploadDialog(context),
                icon: Icon(Icons.post_add_rounded, size: 22.sp),
                tooltip: context.tr('upload_new_material'),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialsHeader(courseName: widget.courseName),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocListener<CourseMaterialsBloc, CourseMaterialsState>(
                listener: (context, state) {
                  if (state is DeleteMaterialSuccess ||
                      state is UploadMaterialSuccess ||
                      state is UpdateMaterialSuccess) {
                    _isChanged = true;
                    final message = state is DeleteMaterialSuccess
                        ? state.message
                        : (state is UploadMaterialSuccess
                              ? state.message
                              : (state as UpdateMaterialSuccess).message);

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));

                    context.read<CourseMaterialsBloc>().add(
                      GetCourseMaterialsEvent(slug: widget.slug, page: 1),
                    );
                  } else if (state is DeleteMaterialError ||
                      state is UploadMaterialError ||
                      state is UpdateMaterialError) {
                    final message = state is DeleteMaterialError
                        ? state.message
                        : (state is UploadMaterialError
                              ? state.message
                              : (state as UpdateMaterialError).message);

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  }
                },
                child: BlocBuilder<CourseMaterialsBloc, CourseMaterialsState>(
                  builder: (context, state) {
                    if (state is CourseMaterialsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is CourseMaterialsError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is CourseMaterialsLoaded) {
                      final materials = state.materialsListUIModel.materials;

                      if (materials.isEmpty) {
                        return const MaterialsEmptyState();
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        itemCount:
                            materials.length +
                            (state.isPaginationLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < materials.length) {
                            return MaterialCard(
                              material: materials[index],
                              onDelete: () => _handleDelete(materials[index]),
                              onEdit: () => _showUploadDialog(
                                context,
                                material: materials[index],
                              ),
                            );
                          } else {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDelete(CourseMaterialItemUIModel material) {
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

  void _showUploadDialog(
    BuildContext context, {
    CourseMaterialItemUIModel? material,
  }) async {
    final bloc = context.read<CourseMaterialsBloc>();
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: bloc,
        child: UploadMaterialDialog(
          courseSlug: widget.slug,
          material: material,
        ),
      ),
    );

    if (result == true && mounted) {
      _isChanged = true;
      bloc.add(GetCourseMaterialsEvent(slug: widget.slug, page: 1));
    }
  }
}
