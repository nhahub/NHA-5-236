import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomCardStatusInfoMobile extends StatefulWidget {
  final String title;
  final String num;
  final Color colortitle;
  final Color colornum;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color colorIcon;
  final IconData icon;

  const CustomCardStatusInfoMobile({
    super.key,
    required this.title,
    required this.num,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.colorIcon,
    required this.colornum,
    required this.colortitle,
    required this.icon,
  });

  @override
  State<CustomCardStatusInfoMobile> createState() =>
      _CustomCardStatusInfoMobileState();
}

class _CustomCardStatusInfoMobileState
    extends State<CustomCardStatusInfoMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      width: 163.w,
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [widget.color1, widget.color2, widget.color3],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 1,
            offset: const Offset(3, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(widget.icon, color: widget.colorIcon.withValues(alpha: 0.5)),
          const Spacer(),
          Text(
            widget.num,
            style: context.textTheme.titleLarge?.copyWith(
              color: widget.colornum,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),
          Text(
            widget.title,
            style: context.textTheme.titleLarge?.copyWith(
              color: widget.colortitle,
            ),
          ),
        ],
      ),
    );
  }
}
