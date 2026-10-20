import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomTextFormField extends StatefulWidget {
  final String txt;
  final String hint;
  final double? w;
  final double? h;
  final Color? color;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function()? onSuffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    super.key,
    required this.txt,
    required this.hint,
    this.w,
    this.h,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.validator,
    this.isPassword = false,
    this.maxLines,
    this.onChanged,
    this.onSuffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.w ?? double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          focusNode: widget.focusNode,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontSize: 16.sp,
          ),
          maxLines: widget.maxLines ?? 1,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    size: 18.sp,
                    color: context.colorScheme.onSecondary.withValues(
                      alpha: 0.7,
                    ),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  )
                : widget.suffixIcon != null
                ? (widget.onSuffixIcon != null
                      ? IconButton(
                          onPressed: widget.onSuffixIcon,
                          icon: Icon(
                            widget.suffixIcon,
                            size: 18.sp,
                            color: context.colorScheme.onSecondary,
                          ),
                        )
                      : Icon(
                          widget.suffixIcon,
                          size: 18.sp,
                          color: context.colorScheme.onSecondary,
                        ))
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            labelText: widget.txt.isEmpty ? null : widget.txt,
            labelStyle: TextStyle(
              color: widget.color ?? context.colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
            ),
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: context.colorScheme.onSurfaceVariant.withValues(
                alpha: 0.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: context.colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: context.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: context.colorScheme.error,
                width: 1.5,
              ),
            ),
          ),
          cursorColor: context.colorScheme.primary,
        ),
      ),
    );
  }
}
