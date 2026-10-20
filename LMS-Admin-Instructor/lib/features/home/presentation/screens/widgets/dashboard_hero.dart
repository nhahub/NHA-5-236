import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/theme/app_assets.dart';
import 'package:lms_admin_instructor/features/home/presentation/screens/widgets/custom_rich_text.dart';

class DashboardHero extends StatelessWidget {
  final String userName;
  const DashboardHero({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36.r),
          bottomRight: Radius.circular(36.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24.w : 60.w,
          vertical: 48.h,
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTextContent(context, isMobile),
                  SizedBox(height: 32.h),
                  _buildHeroImage(isMobile),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildTextContent(context, isMobile),
                  ),
                  SizedBox(width: 40.w),
                  Expanded(flex: 2, child: _buildHeroImage(isMobile)),
                ],
              ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "${context.tr('welcome_back')}, $userName 👋",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.colorScheme.onPrimaryContainer.withValues(
              alpha: 0.8,
            ),
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 16.h),
        isMobile
            ? const Center(child: CustomRichText())
            : const CustomRichText(),
        SizedBox(height: 24.h),
        Container(
          width: isMobile ? double.infinity : 550.w,
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimaryContainer.withValues(
              alpha: 0.08,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Text(
              context.tr('join_learners_desc'),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorScheme.onPrimaryContainer,
                height: 1.6,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(bool isMobile) {
    return Center(
      child: Image.asset(
        AppAssets.authImage,
        fit: BoxFit.contain,
        height: isMobile ? 120.h : 220.h,
      ),
    );
  }
}
