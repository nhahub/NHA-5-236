import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/common/user_model.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/home/presentation/screens/widgets/dashboard_feature_card.dart';
import 'package:lms_admin_instructor/features/home/presentation/screens/widgets/dashboard_hero.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userJson = sl<CacheHelper>().getData(key: ApiKey.user);
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      final user = UserModel.fromJson(userMap);
      setState(() {
        _userName = user.firstName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.005),
      appBar: isMobile
          ? AppBar(
              title: Text(
                context.tr('dashboard'),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.person_outline),
                  onPressed: () =>
                      context.pushNamed(AppRoutes.instructorProfileScreen),
                ),
                SizedBox(width: 8.w),
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashboardHero(userName: _userName),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24.w : 60.w,
                vertical: 60.h,
              ),
              child: Column(
                children: [
                  // --- Heading Section (Like the image) ---
                  Center(
                    child: Column(
                      children: [
                        Text(
                          context.tr('about_app_title'),
                          textAlign: TextAlign.center,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: context.colorScheme.onSurface,
                            fontSize: isMobile ? 22.sp : 32.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: isMobile ? double.infinity : 600.w,
                          child: Text(
                            context.tr('about_app_desc'),
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                              height: 1.6,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.h),

                  // --- Features Grid (Responsive) ---
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (isMobile) {
                        return Column(children: _buildFeatureCards(context));
                      }
                      return Wrap(
                        spacing: 24.w,
                        runSpacing: 24.h,
                        alignment: WrapAlignment.center,
                        children: _buildFeatureCards(context)
                            .map(
                              (card) => SizedBox(
                                width:
                                    (constraints.maxWidth - 48.w) /
                                    (context.isDesktop ? 3 : 2),
                                child: card,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                  SizedBox(height: 80.h),

                  // --- Bottom Info ---
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(32.r),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withValues(
                        alpha: 0.03,
                      ),
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          context.tr('ready_to_start_journey'),
                          textAlign: TextAlign.center,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Commit Ma3ana Administrative Hub v1.0.0",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onSurface.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFeatureCards(BuildContext context) {
    return [
      DashboardFeatureCard(
        title: context.tr('feature_user_mgmt_title'),
        description: context.tr('feature_user_mgmt_desc'),
        icon: Icons.admin_panel_settings_outlined,
      ),
      DashboardFeatureCard(
        title: context.tr('feature_course_catalog_title'),
        description: context.tr('feature_course_catalog_desc'),
        icon: Icons.auto_stories_outlined,
      ),
      DashboardFeatureCard(
        title: context.tr('feature_student_tracking_title'),
        description: context.tr('feature_student_tracking_desc'),
        icon: Icons.analytics_outlined,
      ),
      DashboardFeatureCard(
        title: context.tr('feature_interactive_learning_title'),
        description: context.tr('feature_interactive_learning_desc'),
        icon: Icons.quiz_outlined,
      ),
    ];
  }
}
