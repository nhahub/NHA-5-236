import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/settings/presentation/screens/widgets/settings_section.dart';
import 'package:lms_admin_instructor/features/settings/presentation/screens/widgets/settings_tile.dart';
import 'package:lms_admin_instructor/features/settings/presentation/screens/widgets/language_dialog.dart';
import 'package:lms_admin_instructor/features/settings/presentation/screens/widgets/logout_dialog.dart';
import 'package:lms_admin_instructor/core/theme/theme_cubit.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.goNamed(AppRoutes.loginScreen);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.w : 60.w,
            vertical: 80.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('settings'),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.colorScheme.onSurface,
                  fontSize: isMobile ? 22.sp : 28.sp,
                ),
              ),
              SizedBox(height: 32.h),
              SettingsSection(
                title: context.tr('account'),
                items: [
                  SettingsTile(
                    icon: Icons.person_outline,
                    title: context.tr('profile'),
                    subtitle: context.tr('manage_profile_desc'),
                    onTap: () {
                      final roleStr =
                          sl<CacheHelper>().getDataString(key: ApiKey.role) ??
                          '';
                      final role = UserRole.fromString(roleStr);
                      if (role == UserRole.admin) {
                        context.pushNamed(AppRoutes.adminProfileScreen);
                      } else {
                        context.pushNamed(AppRoutes.instructorProfileScreen);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SettingsSection(
                title: context.tr('appearance'),
                items: [
                  SettingsTile(
                    icon: Icons.dark_mode_outlined,
                    title: context.tr('dark_mode'),
                    subtitle: context.tr('dark_mode_desc'),
                    trailing: Switch(
                      value: Theme.of(context).brightness == Brightness.dark,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                    iconColor: context.colorScheme.onSecondary,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SettingsSection(
                title: context.tr('language'),
                items: [
                  SettingsTile(
                    icon: Icons.language_outlined,
                    title: context.tr('language'),
                    subtitle:
                        Localizations.localeOf(context).languageCode == 'en'
                        ? context.tr('english')
                        : context.tr('arabic'),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => const LanguageDialog(),
                    ),
                    iconColor: context.colorScheme.secondary,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SettingsSection(
                title: context.tr('security'),
                items: [
                  SettingsTile(
                    icon: Icons.lock_outline_rounded,
                    title: context.tr('change_password'),
                    subtitle: context.tr('update_security_desc'),
                    iconColor: context.colorScheme.onSurface,
                    onTap: () {
                      context.pushNamed(AppRoutes.changePasswordScreen);
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SettingsSection(
                title: context.tr('system'),
                items: [
                  SettingsTile(
                    icon: Icons.logout_outlined,
                    title: context.tr('logout'),
                    subtitle: context.tr('logout_desc'),
                    titleColor: context.colorScheme.error,
                    iconColor: context.colorScheme.error,
                    onTap: () => showDialog(
                      context: context,
                      builder: (innerContext) => BlocProvider.value(
                        value: context.read<AuthBloc>(),
                        child: const LogoutDialog(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
