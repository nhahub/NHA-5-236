import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomInstructorStatusMobile extends StatefulWidget {
  final String title;
  final String num;
  final Color colortitle;
  final Color colornum;
  final Color color;

  final Color colorIcon;
  final IconData icon;
  const CustomInstructorStatusMobile({
    super.key,
    required this.title,
    required this.num,
    required this.color,

    required this.colorIcon,
    required this.colornum,
    required this.colortitle,
    required this.icon,
  });

  @override
  State<CustomInstructorStatusMobile> createState() =>
      _CustomInstructorStatusMobileState();
}

class _CustomInstructorStatusMobileState
    extends State<CustomInstructorStatusMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      width: 163.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(widget.icon, color: widget.colorIcon),
          const Spacer(),
          Text(
            widget.title,
            style: context.textTheme.bodyLarge?.copyWith(
              color: widget.colortitle,
            ),
          ),
          const Spacer(),
          Text(
            widget.num,
            style: context.textTheme.titleLarge?.copyWith(
              color: widget.colornum,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
