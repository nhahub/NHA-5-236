// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';

class CustomSearchBarr extends StatefulWidget {
  final String hint;
  final double? w;
  final double? h;
  final double? r;
  final Color? color;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  const CustomSearchBarr({
    super.key,
    required this.hint,
    this.w,
    this.h,
    this.r,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  State<CustomSearchBarr> createState() => _SearchBar();
}

class _SearchBar extends State<CustomSearchBarr> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getResponsiveSize(context: context, webSize: 400, mobileSize: 250),
      height: getResponsiveSize(context: context, webSize: 60, mobileSize: 50),
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.primary,
          fontSize: getResponsiveSize(
            context: context,
            webSize: 16,
            mobileSize: 14,
          ),
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.r ?? 8.0),
            borderSide: BorderSide(
              color: widget.color ?? context.colorScheme.outline,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.r ?? 8.0),
            borderSide: BorderSide(
              color: context.colorScheme.primary,
              width: 1.5,
            ),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, size: 20)
              : null,
          contentPadding: const EdgeInsets.only(
            bottom: 15,
            top: 10,
            left: 16,
            right: 16,
          ),
          hintText: widget.hint,
          hintStyle: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        onFieldSubmitted: widget.onFieldSubmitted,
        cursorHeight: 24,
        cursorColor: context.colorScheme.primary,
      ),
    );
  }
}
