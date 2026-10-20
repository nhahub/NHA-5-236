import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? iconPadding;
  final double? iconSize;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final Color? color;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.width,
    this.height,
    this.iconPadding,
    this.iconSize,
    this.textStyle,
    this.style,
    this.color,
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultColor =
        textStyle?.color ??
        style?.foregroundColor?.resolve({}) ??
        context.colorScheme.onPrimary;

    return SizedBox(
      width: width ?? 278,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onTap,
        style:
            style?.copyWith(
              padding: WidgetStatePropertyAll(
                padding ??
                    EdgeInsets.symmetric(
                      horizontal: context.isMobile ? 8.w : 12.w,
                      vertical: context.isMobile ? 4.h : 8.h,
                    ),
              ),
            ) ??
            ElevatedButton.styleFrom(
              padding:
                  padding ??
                  EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 16.w : 32.w,
                    vertical: context.isMobile ? 8.h : 16.h,
                  ),
            ),
        child:
            child ??
            IconTheme(
              data: IconThemeData(color: defaultColor, size: iconSize ?? 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: iconPadding ?? 8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      style: (textStyle ?? context.textTheme.labelLarge)
                          ?.copyWith(
                            color: defaultColor,
                            fontSize:
                                textStyle?.fontSize ??
                                getResponsiveSize(
                                  context: context,
                                  webSize: 16,
                                  mobileSize: 14,
                                ),
                          ),
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: iconPadding ?? 8),
                    suffixIcon!,
                  ],
                ],
              ),
            ),
      ),
    );
  }
}
