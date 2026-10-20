// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String description;
  final String? image;
  final int? total_num;
  final Function() onTap;
  final IconData? icon;
  final String bottom_action;
  final Function()? onDelete;
  const CustomCard({
    super.key,
    required this.title,
    required this.description,
    this.image,
    this.total_num,
    required this.onTap,
    this.icon,
    required this.bottom_action,
    this.onDelete,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      width: 342.w,
      height: 190.h,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomImage(
                imagePath: widget.image,
                width: 80,
                height: 80,
                borderRadius: BorderRadius.circular(12.r),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      widget.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.onDelete != null)
                IconButton(
                  onPressed: widget.onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: context.colorScheme.error,
                  ),
                ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: context.colorScheme.primary),
                SizedBox(width: 8.w),
              ],
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.total_num}",
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: context.tr('courses_count_label'),
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomPrimaryButton(
                text: context.tr('manage_btn'),
                onTap: widget.onTap,
                width: 120,
                height: 40,
                // borderRadius: BorderRadius.circular(12.r),
                color: context.colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
