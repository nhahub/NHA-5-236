import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/screens/widgets/package_courses_section/package_courses_section.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/screens/widgets/package_info_section/package_info_card.dart';

import '../../domain/entity/package_details_ui_model.dart';
import '../bloc/package_details_bloc.dart';
import '../bloc/package_details_event.dart';
import '../bloc/package_details_state.dart';

class PackageDetailsScreen extends StatefulWidget {
  final String slug;
  const PackageDetailsScreen({super.key, required this.slug});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
  final bool _wasUpdated = false;

  @override
  void initState() {
    super.initState();
    context.read<PackageDetailsBloc>().add(
      GetPackageDetailsEvent(slug: widget.slug),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.pop(_wasUpdated);
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceContainerHighest,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop ? 64.w : 8.w,
            ),
            child: InkWell(
              onTap: () => context.pop(_wasUpdated),
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
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          toolbarHeight: context.isDesktop ? 80.h : 60.h,
        ),
        body: BlocBuilder<PackageDetailsBloc, PackageDetailsState>(
          builder: (context, state) {
            if (state is PackageDetailsLoading ||
                state is PackageDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PackageDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is PackageDetailsLoaded) {
              return _buildBody(context, state.packageDetails);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PackageDetailsUIModel package) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.isDesktop ? 80.w : 20.w,
        vertical: 40.h,
      ).copyWith(top: context.isDesktop ? 60.h : 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PackageInfoCard(package: package),
          SizedBox(height: 40.h),
          PackageCoursesSection(courses: package.courses),
        ],
      ),
    );
  }
}
