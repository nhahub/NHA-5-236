import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/theme/app_assets.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';

class LoginLeftSide extends StatelessWidget {
  const LoginLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.primary,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getResponsiveSize(
                    context: context,
                    webSize: 64,
                    mobileSize: 24,
                  ),
                  vertical: 48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            AppAssets.appLogo,
                            width: 22.w,
                            height: 22.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          context.tr('commit_ma3ana'),
                          style: context.textTheme.titleMedium!.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 320.w,
                              height: 320.h,
                              child: Image.asset(
                                AppAssets.authImage,
                                width: 320.w,
                                height: 320.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 48.h),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: context.textTheme.headlineMedium!
                                    .copyWith(
                                      color: context.colorScheme.onPrimary,
                                      fontWeight: FontWeight.w900,
                                      height: 1.2,
                                    ),
                                children: [
                                  TextSpan(
                                    text: "${context.tr('commit_today')}\n",
                                  ),
                                  TextSpan(
                                    text: context.tr('build_your_future'),
                                    style: TextStyle(
                                      color: context.colorScheme.secondary,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              context.tr('join_learners_desc'),
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: context.colorScheme.onPrimary.withValues(
                                  alpha: 0.7,
                                ),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Center(
                      child: Wrap(
                        spacing: 32,
                        runSpacing: 16,
                        children: [
                          _buildBottomLink(context, "Learn by doing"),
                          _buildBottomLink(context, "Track progress"),
                          _buildBottomLink(context, "Grow daily"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomLink(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.labelMedium!.copyWith(
        color: context.colorScheme.onPrimary.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
