import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomSearchAppBar extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Color? color;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? width;
  final double? height;
  final double? radius;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  const CustomSearchAppBar({
    super.key,
    required this.hint,
    required this.controller,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.radius,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  State<CustomSearchAppBar> createState() => _CustomSearchAppBarState();
}

class _CustomSearchAppBarState extends State<CustomSearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width?.w ?? 240.w,
      height: widget.height?.h ?? 44.h,
      child: TextFormField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        style: context.textTheme.labelLarge?.copyWith(
          color: context.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius?.r ?? 10.r),
            borderSide: BorderSide(
              color:
                  widget.color ??
                  context.colorScheme.outline.withValues(alpha: 0.5),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius?.r ?? 10.r),
            borderSide: BorderSide(
              color: context.colorScheme.primary,
              width: 1.2.w,
            ),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: 20.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                )
              : null,
          suffixIcon: widget.suffixIcon != null
              ? Icon(
                  widget.suffixIcon,
                  size: 20.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          hintText: widget.hint,
          hintStyle: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          filled: true,
          fillColor:
              widget.color?.withValues(alpha: 0.05) ??
              context.colorScheme.surface,
        ),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        cursorHeight: 18.sp,
        cursorColor: context.colorScheme.primary,
      ),
    );
  }
}
