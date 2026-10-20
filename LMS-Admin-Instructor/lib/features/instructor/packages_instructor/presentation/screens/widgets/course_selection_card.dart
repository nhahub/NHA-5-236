import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CourseSelectionCard extends StatelessWidget {
  final String title;
  final String? category;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final bool showCheckbox;

  const CourseSelectionCard({
    super.key,
    required this.title,
    this.category,
    this.isSelected = false,
    this.onChanged,
    this.showCheckbox = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!isSelected) : null,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.onSurface.withValues(alpha: 0.1),
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.image_outlined,
                color: context.colorScheme.primary,
                size: 24.r,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (category != null && category!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      category!,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Checkbox
            if (showCheckbox)
              Container(
                width: 24.r,
                height: 24.r,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurface.withValues(alpha: 0.3),
                    width: 2.w,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: context.colorScheme.onPrimary,
                        size: 16.r,
                      )
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
