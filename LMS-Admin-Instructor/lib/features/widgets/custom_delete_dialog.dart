import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class CustomDeleteDialog extends StatefulWidget {
  final String title;
  final String warningMessage;
  final String consequencesMessage;
  final VoidCallback onDelete;
  final String? confirmText;

  const CustomDeleteDialog({
    super.key,
    required this.title,
    required this.warningMessage,
    required this.consequencesMessage,
    required this.onDelete,
    this.confirmText,
  });

  @override
  State<CustomDeleteDialog> createState() => _CustomDeleteDialogState();
}

class _CustomDeleteDialogState extends State<CustomDeleteDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isDeleteEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final expectedText =
          (widget.confirmText ?? context.tr('delete_confirm_text'))
              .toLowerCase();
      setState(() {
        _isDeleteEnabled =
            _controller.text.trim().toLowerCase() == expectedText;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expectedText =
        widget.confirmText ?? context.tr('delete_confirm_text');

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: context.colorScheme.error,
            size: 28.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            widget.title,
            style: TextStyle(
              color: context.colorScheme.error,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 450.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: context.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: context.colorScheme.error.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.warningMessage,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.consequencesMessage,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.error.withValues(alpha: 0.8),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            RichText(
              text: TextSpan(
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(text: "${context.tr('type_delete_to_confirm')} "),
                  TextSpan(
                    text: "'$expectedText'",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " ${context.tr('to_confirm_deletion')}"),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _controller,
              autofocus: true,
              onFieldSubmitted: (value) {
                if (_isDeleteEnabled) {
                  widget.onDelete();
                  Navigator.pop(context);
                }
              },
              decoration: InputDecoration(
                hintText: expectedText,
                filled: true,
                fillColor: context.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: context.colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: context.colorScheme.error,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.tr('cancel'),
            style: TextStyle(
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
        SizedBox(
          width: 130.w,
          child: CustomPrimaryButton(
            onTap: _isDeleteEnabled
                ? () {
                    widget.onDelete();
                    Navigator.pop(context);
                  }
                : null,
            text: context.tr('delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.error,
              foregroundColor: context.colorScheme.onError,
              disabledBackgroundColor: context.colorScheme.error.withValues(
                alpha: 0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
