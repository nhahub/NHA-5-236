import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class CustomCourseCardDisktop extends StatefulWidget {
  final String title;
  final String description;
  final String? image;
  final int totalStudents;
  final double rating;
  final String duration;
  final VoidCallback onTap;

  const CustomCourseCardDisktop({
    super.key,
    required this.title,
    required this.description,
    this.image,
    required this.totalStudents,
    required this.rating,
    required this.duration,
    required this.onTap,
  });

  @override
  State<CustomCourseCardDisktop> createState() =>
      _CustomCourseCardDisktopState();
}

class _CustomCourseCardDisktopState extends State<CustomCourseCardDisktop> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _isHovered
                ? context.colorScheme.primary.withValues(alpha: 0.5)
                : context.colorScheme.outline.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.04),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Stack(
                children: [
                  CustomImage(
                    imagePath: widget.image,
                    width: double.infinity,
                    height: 180.h,
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    top: 12.r,
                    right: 12.r,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.r),
                          SizedBox(width: 4.w),
                          Text(
                            widget.rating.toString(),
                            style: context.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Metadata Row
                  Row(
                    children: [
                      _buildInfoItem(
                        context,
                        Icons.people_outline,
                        "${widget.totalStudents} Students",
                      ),
                      const Spacer(),
                      _buildInfoItem(
                        context,
                        Icons.access_time,
                        widget.duration,
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Action Button
                  CustomPrimaryButton(
                    text: "Manage Course",
                    onTap: widget.onTap,
                    width: double.infinity,
                    height: 45,
                    // borderRadius: BorderRadius.circular(12.r),
                    color: _isHovered
                        ? context.colorScheme.primary
                        : context.colorScheme.primary.withValues(alpha: 0.9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.r,
          color: context.colorScheme.primary.withValues(alpha: 0.7),
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
