import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  required Color backgroundColor,
  required IconData icon,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
