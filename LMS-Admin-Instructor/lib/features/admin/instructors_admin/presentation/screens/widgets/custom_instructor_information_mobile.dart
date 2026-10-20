import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class CustomInstructorInformationMobile extends StatefulWidget {
  final String name;
  final String title;
  final String image;
  const CustomInstructorInformationMobile({
    super.key,
    required this.name,
    required this.title,
    required this.image,
  });

  @override
  State<CustomInstructorInformationMobile> createState() =>
      _CustomInstructorInformationMobileState();
}

class _CustomInstructorInformationMobileState
    extends State<CustomInstructorInformationMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      width: 340.w,
      height: 280.h,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            CustomImage(imagePath: widget.image, width: 128, height: 128),
            SizedBox(height: 16.h),
            Text(
              widget.name,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              widget.title,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
