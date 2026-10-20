import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/data/model/create_package_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/widgets/snack_bar_widget.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/screens/widgets/course_selection_card.dart';

class AddPackageDialog extends StatefulWidget {
  const AddPackageDialog({super.key});

  @override
  State<AddPackageDialog> createState() => _AddPackageDialogState();
}

class _AddPackageDialogState extends State<AddPackageDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  List<String> _selectedCourseSlugs = [];
  bool _showAllCourses = false;

  @override
  void initState() {
    super.initState();
    final instructorSlug =
        sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
    context.read<PackagesInstructorBloc>().add(
      GetInstructorCoursesForPackageEvent(instructorSlug: instructorSlug),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCourseSlugs.isEmpty) {
        showCustomSnackBar(
          context,
          message: context.tr('please_select_courses'),
          backgroundColor: context.colorScheme.error,
          icon: Icons.error,
        );
        return;
      }

      final requestModel = CreatePackageRequestModel(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        price: _priceController.text.trim(),
        courses: _selectedCourseSlugs,
      );

      context.read<PackagesInstructorBloc>().add(
        CreatePackageEvent(requestModel: requestModel),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: 800.w,
        height: 600.h,
        padding: EdgeInsets.all(32.r),
        child: BlocConsumer<PackagesInstructorBloc, PackagesInstructorState>(
          listener: (context, state) {
            if (state is CreatePackageSuccess) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: context.colorScheme.secondary,
                icon: Icons.check_circle,
              );
              Navigator.of(context).pop(true);
            } else if (state is CreatePackageError) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: context.colorScheme.error,
                icon: Icons.error,
              );
            }
          },
          builder: (context, state) {
            List<CourseInstructorItemUIModel> availableCourses = [];
            if (state is InstructorCoursesLoaded) {
              availableCourses = state.courses;
            } else if (state is CreatePackageLoading) {
              availableCourses = state.courses;
            } else if (state is CreatePackageError) {
              availableCourses = state.courses;
            } else if (state is CreatePackageSuccess) {
              availableCourses = state.courses;
            }

            final isLoading =
                state is CreatePackageLoading ||
                state is InstructorCoursesLoading;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.tr('create_new_package'),
                      style: context.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            txt: context.tr('title'),
                            controller: _titleController,
                            hint: context.tr('title'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.tr('required_field');
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            txt: context.tr('description'),
                            controller: _descriptionController,
                            hint: context.tr('description'),
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.tr('required_field');
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            txt: context.tr('price'),
                            controller: _priceController,
                            hint: context.tr('price'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.tr('required_field');
                              }
                              if (double.tryParse(value) == null) {
                                return context.tr('invalid_price');
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.tr('select_courses'),
                                style: context.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  '${_selectedCourseSlugs.length} ${context.tr('courses_selected')}',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        color: context.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          state is InstructorCoursesLoading
                              ? const Center(child: CircularProgressIndicator())
                              : state is InstructorCoursesError
                              ? Center(
                                  child: Text(
                                    state.message,
                                    style: TextStyle(
                                      color: context.colorScheme.error,
                                    ),
                                  ),
                                )
                              : availableCourses.isEmpty
                              ? Center(
                                  child: Text(context.tr('no_courses_found')),
                                )
                              : Column(
                                  children: [
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16.w,
                                            mainAxisSpacing: 16.h,
                                            mainAxisExtent: 90.h,
                                          ),
                                      itemCount: _showAllCourses
                                          ? availableCourses.length
                                          : (availableCourses.length > 4
                                                ? 4
                                                : availableCourses.length),
                                      itemBuilder: (context, index) {
                                        final course = availableCourses[index];
                                        final isSelected = _selectedCourseSlugs
                                            .contains(course.slug);
                                        return CourseSelectionCard(
                                          title: course.title,
                                          isSelected: isSelected,
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                _selectedCourseSlugs.add(
                                                  course.slug,
                                                );
                                              } else {
                                                _selectedCourseSlugs.remove(
                                                  course.slug,
                                                );
                                              }
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    if (!_showAllCourses &&
                                        availableCourses.length > 4) ...[
                                      SizedBox(height: 16.h),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              _showAllCourses = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: context.colorScheme.primary,
                                          ),
                                          label: Text(
                                            context.tr('browse_more_courses'),
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                  color: context
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(context.tr('cancel')),
                    ),
                    SizedBox(width: 16.w),
                    CustomPrimaryButton(
                      onTap: isLoading ? null : _submit,
                      text: context.tr('create'),
                      width: 120.w,
                      height: 48.h,
                      child: isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
