import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/data/models/update_package_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/domain/entity/package_details_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/bloc/package_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/bloc/package_details_event.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/bloc/package_details_state.dart';
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

class EditPackageDialog extends StatefulWidget {
  final PackageDetailsUIModel package;

  const EditPackageDialog({super.key, required this.package});

  @override
  State<EditPackageDialog> createState() => _EditPackageDialogState();
}

class _EditPackageDialogState extends State<EditPackageDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  List<String> _selectedCourseSlugs = [];
  bool _showAllCourses = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.package.title);
    _descriptionController = TextEditingController(text: widget.package.description);
    _priceController = TextEditingController(text: widget.package.price.toString());

    _selectedCourseSlugs = widget.package.courses.map((e) => e.slug).toList();

    final instructorSlug = sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
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

      final requestModel = UpdatePackageRequestModel(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        price: _priceController.text.trim(),
        courses: _selectedCourseSlugs,
      );

      context.read<PackageDetailsBloc>().add(
        UpdatePackageDetailsEvent(
          slug: widget.package.slug,
          requestModel: requestModel,
        ),
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
        child: MultiBlocListener(
          listeners: [
            BlocListener<PackageDetailsBloc, PackageDetailsState>(
              listener: (context, state) {
                if (state is UpdatePackageSuccess) {
                  showCustomSnackBar(
                    context,
                    message: context.tr('package_updated_success'),
                    backgroundColor: context.colorScheme.secondary,
                    icon: Icons.check_circle,
                  );
                  context.pop();
                  context.read<PackageDetailsBloc>().add(
                    GetPackageDetailsEvent(slug: widget.package.slug),
                  );
                } else if (state is UpdatePackageError) {
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
          child: BlocBuilder<PackagesInstructorBloc, PackagesInstructorState>(
            builder: (context, packagesState) {
              List<CourseInstructorItemUIModel> availableCourses = [];
              if (packagesState is InstructorCoursesLoaded) {
                availableCourses = packagesState.courses;
              } else if (packagesState is CreatePackageLoading) {
                availableCourses = packagesState.courses;
              } else if (packagesState is CreatePackageError) {
                availableCourses = packagesState.courses;
              } else if (packagesState is CreatePackageSuccess) {
                availableCourses = packagesState.courses;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr('edit_package'),
                        style: context.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => context.pop(),
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
                                    '${_selectedCourseSlugs.length} Courses Selected',
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
                            packagesState is InstructorCoursesLoading
                                ? const Center(child: CircularProgressIndicator())
                                : packagesState is InstructorCoursesError
                                ? Center(
                                    child: Text(
                                      packagesState.message,
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
                                        physics: const NeverScrollableScrollPhysics(),
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
                                                  _selectedCourseSlugs.add(course.slug);
                                                } else {
                                                  _selectedCourseSlugs.remove(course.slug);
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
                                              'Browse More Courses',
                                              style: context.textTheme.titleMedium
                                                  ?.copyWith(
                                                    color: context.colorScheme.primary,
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
                        onPressed: () => context.pop(),
                        child: Text(context.tr('cancel')),
                      ),
                      SizedBox(width: 16.w),
                      BlocBuilder<PackageDetailsBloc, PackageDetailsState>(
                        builder: (context, detailsState) {
                          return CustomPrimaryButton(
                            onTap: detailsState is UpdatePackageLoading ? null : _submit,
                            text: context.tr('save_changes'),
                            width: 200.w,
                            height: 48.h,
                            child: detailsState is UpdatePackageLoading
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
              );
            },
          ),
        ),
      ),
    );
  }
}
