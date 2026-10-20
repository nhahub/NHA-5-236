import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_details_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/edit_course_controller_mixin.dart';

class EditCourseDialog extends StatefulWidget {
  final CourseDetailsUIModel course;

  const EditCourseDialog({super.key, required this.course});

  @override
  State<EditCourseDialog> createState() => _EditCourseDialogState();
}

class _EditCourseDialogState extends State<EditCourseDialog>
    with EditCourseControllerMixin {
  final List<String> _levels = ['beginner', 'intermediate', 'advanced'];

  @override
  void initState() {
    super.initState();
    initControllers(widget.course);
  }

  @override
  void dispose() {
    disposeEditControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: context.colorScheme.surface,
      child: Container(
        width: 600.w,
        padding: EdgeInsets.symmetric(horizontal: 64.r, vertical: 40.r),
        child: SingleChildScrollView(
          child: BlocListener<CourseDetailsBloc, CourseDetailsState>(
            listener: (context, state) {
              if (state is UpdateCourseSuccess) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr('course_updated_success'))),
                );
                context.read<CourseDetailsBloc>().add(
                  GetCourseDetailsEvent(slug: widget.course.slug),
                );
              } else if (state is UpdateCourseError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('edit_course'),
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  CustomTextFormField(
                    txt: context.tr('course_name'),
                    hint: context.tr('course_name_hint'),
                    controller: nameController,
                    validator: (v) =>
                        v!.isEmpty ? context.tr('required_field') : null,
                  ),
                  SizedBox(height: 34.h),
                  CustomTextFormField(
                    txt: context.tr('description'),
                    hint: context.tr('course_description_hint'),
                    controller: descriptionController,
                    maxLines: 4,
                    validator: (v) =>
                        v!.isEmpty ? context.tr('required_field') : null,
                  ),
                  SizedBox(height: 34.h),
                  CustomTextFormField(
                    txt: context.tr('category'),
                    hint: context.tr('category_hint'),
                    controller: categoryController,
                    validator: (v) =>
                        v!.isEmpty ? context.tr('required_field') : null,
                  ),
                  SizedBox(height: 34.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          initialValue: selectedLevel,
                          decoration: InputDecoration(
                            labelText: context.tr('level'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          items: _levels
                              .map(
                                (l) => DropdownMenuItem(
                                  value: l,
                                  child: Text(context.tr(l)),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => selectedLevel = v),
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Expanded(
                        child: CustomTextFormField(
                          txt: context.tr('price'),
                          hint: context.tr('price_hint'),
                          controller: priceController,
                          validator: (v) =>
                              v!.isEmpty ? context.tr('required_field') : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      Icon(
                        isActive ? Icons.check_circle : Icons.cancel,
                        color: isActive
                            ? context.colorScheme.secondary
                            : context.colorScheme.error,
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        context.tr('is_active'),
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: isActive,
                        onChanged: (v) => setState(() => isActive = v),
                        activeThumbColor: context.colorScheme.secondary,
                      ),
                    ],
                  ),
                  SizedBox(height: 48.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: Text(context.tr('cancel')),
                      ),
                      SizedBox(width: 16.w),
                      BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
                        builder: (context, state) {
                          return CustomPrimaryButton(
                            onTap: state is UpdateCourseLoading
                                ? null
                                : _submit,
                            text: context.tr('save_changes'),
                            width: 200.w,
                            height: 48.h,
                            child: state is UpdateCourseLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.h,
                                    child: CircularProgressIndicator(
                                      color: context.colorScheme.surface,
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (formKey.currentState!.validate()) {
      final requestModel = getUpdateRequest();

      context.read<CourseDetailsBloc>().add(
        UpdateCourseDetailsEvent(
          slug: widget.course.slug,
          requestModel: requestModel,
        ),
      );
    }
  }
}
