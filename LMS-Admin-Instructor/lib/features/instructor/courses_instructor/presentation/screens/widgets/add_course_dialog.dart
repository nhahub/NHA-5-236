import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/add_course_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:dio/dio.dart' as dio;

class AddCourseDialog extends StatefulWidget {
  const AddCourseDialog({super.key});

  @override
  State<AddCourseDialog> createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<AddCourseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  String? _selectedLevel;
  XFile? _selectedImage;

  final List<String> _levels = ['beginner', 'intermediate', 'advanced'];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: context.colorScheme.surface,
      child: Container(
        width: 600.w,
        padding: EdgeInsets.all(32.r),
        child: SingleChildScrollView(
          child: BlocListener<CoursesInstructorBloc, CoursesInstructorState>(
            listener: (context, state) {
              if (state is AddCourseSuccess) {
                context.pop();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is AddCourseError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('create_new_course'),
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.tr('create_course_subtitle'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomTextFormField(
                    txt: context.tr('course_name'),
                    hint: context.tr('course_name_hint'),
                    controller: _nameController,
                    validator: (v) =>
                        v!.isEmpty ? context.tr('required_field') : null,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    context.tr('description'),
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: context.tr('course_description_hint'),
                      hintStyle: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.4,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? context.tr('required_field') : null,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    txt: context.tr('category'),
                    hint: context.tr('category_hint'),
                    controller: _categoryController,
                    validator: (v) =>
                        v!.isEmpty ? context.tr('required_field') : null,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedLevel,
                          decoration: InputDecoration(
                            labelText: context.tr('level'),
                            labelStyle: TextStyle(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          hint: Text(
                            context.tr('select_level'),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.4,
                              ),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          items: _levels
                              .map(
                                (l) => DropdownMenuItem(
                                  value: l,
                                  child: Text(
                                    context.tr(l),
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _selectedLevel = v),
                          validator: (v) =>
                              v == null ? context.tr('required_field') : null,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CustomTextFormField(
                          txt: context.tr('price'),
                          hint: context.tr('price_hint'),
                          controller: _priceController,
                          validator: (v) =>
                              v!.isEmpty ? context.tr('required_field') : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    context.tr('course_image'),
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.colorScheme.outline.withValues(
                            alpha: 0.3,
                          ),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: _selectedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 48.sp,
                                  color: context.colorScheme.primary,
                                ),
                                SizedBox(height: 12.h),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: context.tr('upload_file_bold'),
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              color:
                                                  context.colorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${context.tr('drag_drop_text')}',
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: context
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.6),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  context.tr('image_constraints'),
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorScheme.onSurface
                                        .withValues(alpha: 0.4),
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child:
                                      kIsWeb // TODO: check this
                                      ? Image.network(
                                          _selectedImage!.path,
                                          width: double.infinity,
                                          height: 180.h,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(_selectedImage!.path),
                                          width: double.infinity,
                                          height: 180.h,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    onPressed: () =>
                                        setState(() => _selectedImage = null),
                                    icon: Icon(
                                      Icons.close,
                                      color: context.colorScheme.onSurface,
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor:
                                          context.colorScheme.surface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          context.tr('cancel'),
                          style: TextStyle(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      BlocBuilder<
                        CoursesInstructorBloc,
                        CoursesInstructorState
                      >(
                        builder: (context, state) {
                          return CustomPrimaryButton(
                            onTap: state is AddCourseLoading ? () {} : _submit,
                            text: context.tr('create_course'),
                            width: 250.w,
                            height: 48.h,
                            child: state is AddCourseLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.h,
                                    child: CircularProgressIndicator(
                                      color: context.colorScheme.onSurface,
                                      strokeWidth: 2,
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

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('please_select_image'))),
        );
        return;
      }

      final bytes = await _selectedImage!.readAsBytes();
      final multipartFile = dio.MultipartFile.fromBytes(
        bytes,
        filename: _selectedImage!.name,
      );

      final requestModel = AddCourseRequestModel(
        title: _nameController.text,
        description: _descriptionController.text,
        price: _priceController.text,
        category: _categoryController.text,
        level: _selectedLevel!,
        image: multipartFile,
      );

      context.read<CoursesInstructorBloc>().add(
        AddCourseInstructorEvent(requestModel: requestModel),
      );
    }
  }
}
