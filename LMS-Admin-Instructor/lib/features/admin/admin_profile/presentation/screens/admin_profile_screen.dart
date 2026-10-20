import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/domain/entity/admin_profile_ui_model.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/presentation/bloc/admin_profile_bloc.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/presentation/bloc/admin_profile_state.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/presentation/screens/widgets/admin_profile_header.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? 64.w : 8.w,
          ),
          child: InkWell(
            onTap: () => context.pop(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 16.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr('back'),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: context.isDesktop ? 80.h : 60.h,
      ),
      body: BlocConsumer<AdminProfileBloc, AdminProfileState>(
        listener: (context, state) {
          if (state is AdminProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.tr(state.message)),
                backgroundColor: context.colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminProfileLoaded) {
            final AdminProfileUIModel profile = state.profile;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.isDesktop ? 80.w : 20.w,
                vertical: 40.h,
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 800.w),
                  child: AdminProfileHeader(profile: profile),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
