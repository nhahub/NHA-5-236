import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CourseCardHorizontal extends StatelessWidget {
  final String title;
  final String? imagePath;
  final String instructorName;
  final double? progressValue;
  final int? progressPercentage;
  final double? width;
  final double? rating;
  final VoidCallback? onTap;

  const CourseCardHorizontal({
    super.key,
    required this.title,
    this.imagePath,
    required this.instructorName,
    this.progressValue,
    this.progressPercentage,
    this.width,
    this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w ?? double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image
                SizedBox(
                  width: 110.h,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: imagePath != null && imagePath!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: imagePath!,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(Icons.image, size: 24.sp, color: context.colorScheme.surface),
                                ),
                              )
                            : Center(
                                child: Icon(Icons.image, size: 24.sp, color: context.colorScheme.surface),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // title and instructor
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        title,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        instructorName,
                        maxLines: 1,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      // progress
                      if (progressValue != null &&
                          progressPercentage != null) ...[
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context.tr('progress'),
                                  style: context.textTheme.labelSmall,
                                ),
                                Text(
                                  '$progressPercentage%',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                minHeight: 6.h,
                                backgroundColor: context.colorScheme.primary
                                    .withValues(alpha: 0.1),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  context.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 10.h),

                      if (rating != null)
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20.w),
                            SizedBox(width: 2.w),
                            Text(
                              '$rating',
                              style: context.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
