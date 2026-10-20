import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BorderRadiusGeometry? borderRadius;

  const CustomImage({
    super.key,
    this.imagePath,
    this.width,
    this.height,
    this.aspectRatio,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl:
            imagePath ??
            'https://i.pinimg.com/736x/77/97/7e/77977e0f51ec76e51b1360e5f0685d13.jpg',
        width: width?.w,
        height: height?.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: context.colorScheme.surfaceContainerHighest,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) {
          return Container(
            color: context.colorScheme.onSurfaceVariant,
            child: Icon(
              Icons.broken_image,
              color: context.colorScheme.outline,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
