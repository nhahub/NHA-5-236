import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/presentation/bloc/add_new_video_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/presentation/bloc/add_new_video_event.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/presentation/bloc/add_new_video_state.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/error_feedback_widget.dart';
import 'widgets/dashed_rect_painter.dart';

class AddNewVideoScreen extends StatefulWidget {
  final String courseSlug;
  const AddNewVideoScreen({super.key, required this.courseSlug});

  @override
  State<AddNewVideoScreen> createState() => _AddNewVideoScreenState();
}

class _AddNewVideoScreenState extends State<AddNewVideoScreen> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  PlatformFile? _selectedFile;
  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.video,
        allowMultiple: false,
        withData: kIsWeb,
      );

      if (!mounted) return;

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        const maxSize = 250 * 1024 * 1024;
        if (file.size > maxSize) {
          setState(() {
            _errorMessage = context.tr('file_size_exceeds_limit');
            _selectedFile = null;
          });
          return;
        }

        setState(() {
          _selectedFile = file;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = '${context.tr('error_in_video_file')}$e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewVideoBloc, AddNewVideoState>(
      listener: (context, state) {
        if (state is AddNewVideoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.tr('video_added_successfully'))),
          );
          context.pop(true);
        } else if (state is AddNewVideoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
          setState(() {
            _errorMessage = state.message;
          });
        }
      },
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: context.colorScheme.surface,
          child: Container(
            width: context.isDesktop ? 600.w : 400.w,
            padding: EdgeInsets.all(24.r),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('add_new_video'),
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.tr('add_new_video_desc'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    SizedBox(height: 16.h),
                    ErrorFeedbackWidget(
                      errorMessage: _errorMessage!,
                      height: 120.h,
                    ),
                  ],
                  SizedBox(height: 24.h),
                  _buildLabel(context, context.tr('video_title')),
                  CustomTextFormField(
                    txt: context.tr('enter_video_title'),
                    hint: context.tr('enter_video_title'),
                    controller: _titleController,
                  ),
                  SizedBox(height: 16.h),
                  _buildLabel(context, context.tr('youtube_video_url')),
                  CustomTextFormField(
                    txt: context.tr('youtube_url_hint'),
                    hint: context.tr('youtube_url_hint'),
                    controller: _urlController,
                    prefixIcon: Icons.link,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        setState(() {
                          _selectedFile = null;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: context.colorScheme.outline.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          context.tr('or'),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: context.colorScheme.outline.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  _buildLabel(
                    context,
                    context.tr('upload_video_from_device'),
                  ),
                  GestureDetector(
                    onTap: _pickVideo,
                    child: _buildUploadBox(context),
                  ),
                  if (state is AddNewVideoProgress) ...[
                    _buildProgressIndicator(context, state),
                    SizedBox(height: 16.h),
                  ],
                  CustomPrimaryButton(
                    text:
                        (state is AddNewVideoLoading ||
                            state is AddNewVideoProgress)
                        ? context.tr('adding')
                        : context.tr('add_video'),
                    prefixIcon:
                        (state is AddNewVideoLoading ||
                            state is AddNewVideoProgress)
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.file_upload_outlined,
                            color: context.colorScheme.onPrimary,
                            size: 20.sp,
                          ),
                    width: double.infinity,
                    onTap:
                        (state is AddNewVideoLoading ||
                            state is AddNewVideoProgress)
                        ? null
                        : () {
                            if (_titleController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.tr('please_enter_title'),
                                  ),
                                ),
                              );
                              return;
                            }
                            if (_selectedFile == null &&
                                _urlController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.tr('please_provide_video'),
                                  ),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              _errorMessage = null;
                            });
                            context.read<AddNewVideoBloc>().add(
                              AddVideoEvent(
                                courseSlug: widget.courseSlug,
                                title: _titleController.text,
                                course: widget.courseSlug,
                                videoUrl: _urlController.text.isNotEmpty
                                    ? _urlController.text
                                    : null,
                                videoFile: _selectedFile,
                              ),
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: context.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildUploadBox(BuildContext context) {
    return CustomPaint(
      painter: DashedRectPainter(
        color: context.colorScheme.outline.withValues(alpha: 0.5),
        strokeWidth: 1.5,
        gap: 6.0,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _selectedFile != null
                    ? Icons.check_circle_outline
                    : Icons.upload_file_outlined,
                size: 28.sp,
                color: context.colorScheme.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              _selectedFile != null
                  ? _selectedFile!.name
                  : context.tr('click_or_drag_video_to_upload'),
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              _selectedFile != null
                  ? '${(_selectedFile!.size / 1024 / 1024).toStringAsFixed(2)} MB'
                  : context.tr('video_constraints'),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(
    BuildContext context,
    AddNewVideoProgress state,
  ) {
    final sentMb = (state.sent / (1024 * 1024)).toStringAsFixed(1);
    final totalMb = (state.total / (1024 * 1024)).toStringAsFixed(1);
    final percent = (state.progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$sentMb MB / $totalMb MB',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '$percent%',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: state.progress,
            minHeight: 8.h,
            backgroundColor: context.colorScheme.primary.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
              context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
