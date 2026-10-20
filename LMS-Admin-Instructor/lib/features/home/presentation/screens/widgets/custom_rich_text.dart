import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: context.tr('commit_today'),
            style: context.textTheme.displayMedium!.copyWith(
              color: context.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w900,
              fontSize: 48.sp,
            ),
          ),
          TextSpan(
            text: context.tr('build_your_future'),
            style: context.textTheme.displayMedium!.copyWith(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.w900,
              fontSize: 48.sp,
            ),
          ),
        ],
      ),
    );
  }
}
