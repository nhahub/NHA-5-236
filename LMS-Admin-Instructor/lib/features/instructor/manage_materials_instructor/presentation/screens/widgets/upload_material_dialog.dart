import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_event.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_state.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/materials_model/upload_material_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/materials_model/update_material_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';

class UploadMaterialDialog extends StatefulWidget {
  final String courseSlug;
  final CourseMaterialItemUIModel? material;
  const UploadMaterialDialog({
    super.key,
    required this.courseSlug,
    this.material,
  });

  @override
  State<UploadMaterialDialog> createState() => _UploadMaterialDialogState();
}

class _UploadMaterialDialogState extends State<UploadMaterialDialog> {
  late final TextEditingController _nameController;
  PlatformFile? _selectedFile;
  bool _nameError = false;
  bool _fileError = false;

  bool get isEditMode => widget.material != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.material?.materialName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
        _fileError = false;
        if (_nameController.text.isEmpty) {
          _nameController.text = _selectedFile!.name;
          _nameError = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseMaterialsBloc, CourseMaterialsState>(
      listener: (context, state) {
        if (state is UploadMaterialSuccess || state is UpdateMaterialSuccess) {
          final message = state is UploadMaterialSuccess
              ? state.message
              : (state as UpdateMaterialSuccess).message;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
          context.pop(true);
        } else if (state is UploadMaterialError ||
            state is UpdateMaterialError) {
          final message = state is UploadMaterialError
              ? state.message
              : (state as UpdateMaterialError).message;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      },
      builder: (context, state) {
        final isLoading =
            state is UploadMaterialLoading || state is UpdateMaterialLoading;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: context.colorScheme.surface,
          child: Container(
            width: context.isDesktop ? 550.w : 400.w,
            padding: EdgeInsets.all(32.r),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditMode
                        ? context.tr('edit_material')
                        : context.tr('upload_new_material'),
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    isEditMode
                        ? context.tr('update_material_subtitle')
                        : context.tr('create_course_subtitle'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomTextFormField(
                    txt: context.tr('material_name'),
                    hint: context.tr('material_name_hint'),
                    controller: _nameController,
                    onChanged: (value) {
                      if (_nameError && value.isNotEmpty) {
                        setState(() => _nameError = false);
                      }
                    },
                  ),
                  if (_nameError) ...[
                    SizedBox(height: 4.h),
                    Text(
                      context.tr('please_enter_material_name'),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.error,
                      ),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  _buildLabel(context, context.tr('file_resource')),
                  GestureDetector(
                    onTap: _pickFile,
                    child: _buildUploadBox(context),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          context.tr('cancel'),
                          style: TextStyle(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      CustomPrimaryButton(
                        text: isLoading
                            ? (isEditMode
                                  ? context.tr('updating')
                                  : context.tr('uploading'))
                            : (isEditMode
                                  ? context.tr('update_material')
                                  : context.tr('upload_new_material')),
                        width: 250.w,
                        height: 48.h,
                        onTap: isLoading ? null : _handleAction,
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: CircularProgressIndicator(
                                  color: context.colorScheme.onSurface,
                                  strokeWidth: 2,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleAction() {
    setState(() {
      _nameError = _nameController.text.isEmpty;
      _fileError = !isEditMode && _selectedFile == null;
    });

    if (_nameError || _fileError) return;

    if (isEditMode) {
      context.read<CourseMaterialsBloc>().add(
        UpdateMaterialEvent(
          requestModel: UpdateMaterialRequestModel(
            courseSlug: widget.courseSlug,
            slug: widget.material!.slug,
            materialName: _nameController.text,
            file: _selectedFile,
          ),
        ),
      );
    } else {
      context.read<CourseMaterialsBloc>().add(
        UploadMaterialEvent(
          requestModel: UploadMaterialRequestModel(
            materialName: _nameController.text,
            file: _selectedFile!,
            courseSlug: widget.courseSlug,
          ),
        ),
      );
    }
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: context.textTheme.labelLarge),
    );
  }

  Widget _buildUploadBox(BuildContext context) {
    final hasFile = _selectedFile != null;
    final hasExistingFile =
        isEditMode && widget.material?.file != null && !hasFile;

    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _fileError
              ? context.colorScheme.error
              : context.colorScheme.outline.withValues(alpha: 0.3),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasFile || hasExistingFile
                ? Icons.picture_as_pdf_rounded
                : Icons.cloud_upload_outlined,
            size: 48.sp,
            color: context.colorScheme.primary,
          ),
          SizedBox(height: 12.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: hasFile
                      ? _selectedFile!.name
                      : (hasExistingFile
                            ? context.tr('current_file')
                            : (_fileError
                                  ? context.tr('please_select_file')
                                  : context.tr('upload_file_bold'))),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: _fileError
                        ? context.colorScheme.error
                        : context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!hasFile && !hasExistingFile)
                  TextSpan(
                    text: ' ${context.tr('drag_drop_text')}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            hasFile
                ? '${(_selectedFile!.size / 1024 / 1024).toStringAsFixed(2)} MB'
                : context.tr('pdf_files_only'),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
