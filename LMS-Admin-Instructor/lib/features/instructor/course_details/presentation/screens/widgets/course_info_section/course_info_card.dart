import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/update_course_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_details_ui_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_state.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_info_section/edit_course_dialog.dart';
import 'package:image_picker/image_picker.dart';

class CourseInfoCard extends StatelessWidget {
  final CourseDetailsUIModel course;

  const CourseInfoCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop ? 38.r : 16.r,
              vertical: context.isDesktop ? 30.r : 16.r,
            ),
            child: context.isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildThumbnail(context, height: 220.h),
                      SizedBox(width: 32.w),
                      Expanded(child: _buildMainInfo(context)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildThumbnail(
                        context,
                        width: double.infinity,
                        height: 180.h,
                      ),
                      SizedBox(height: 16.h),
                      _buildMainInfo(context),
                    ],
                  ),
          ),
          Divider(
            height: 1,
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop ? 32.r : 16.r,
              vertical: context.isDesktop ? 20.r : 16.r,
            ),
            child: BlocBuilder<CourseStatsBloc, CourseStatsState>(
              builder: (context, state) {
                final stats = _buildStats(context, state);
                return context.isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: stats,
                      )
                    : Wrap(spacing: 16.w, runSpacing: 16.h, children: stats);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return Stack(
      children: [
        Container(
          width: width ?? 240.w,
          height: height ?? 140.h,
          decoration: BoxDecoration(
            color: context.colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: course.image.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: course.image,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        _buildImagePlaceholder(context),
                  )
                : _buildImagePlaceholder(context),
          ),
        ),
        Positioned(
          top: 8.r,
          right: 8.r,
          child: BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
            builder: (context, state) {
              return CircleAvatar(
                backgroundColor: context.colorScheme.surface.withValues(
                  alpha: 0.8,
                ),
                radius: 18.r,
                child: state is UpdateCourseLoading
                    ? SizedBox(
                        height: 20.r,
                        width: 20.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.colorScheme.primary,
                        ),
                      )
                    : IconButton(
                        icon: Icon(Icons.edit, size: 18.sp),
                        onPressed: () => _updateImage(context),
                        padding: EdgeInsets.zero,
                        color: context.colorScheme.primary,
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _updateImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final requestModel = UpdateCourseRequestModel(
        title: course.title,
        description: course.description,
        price: course.price,
        category: course.category,
        level: course.level.toLowerCase(),
        isActive: course.isActive,
        image: image,
      );

      context.read<CourseDetailsBloc>().add(
        UpdateCourseDetailsEvent(slug: course.slug, requestModel: requestModel),
      );
    }
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            context.tr(course.level.toLowerCase()),
            style: TextStyle(
              color: context.colorScheme.surface,
              fontSize: 10.sp,
            ),
          ),
        ),
        Positioned(
          bottom: 8.h,
          right: 8.w,
          child: Text(
            context.tr(course.level.toLowerCase()),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.surface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (context.isDesktop)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTitle(context)),
              _buildActionButtons(context),
            ],
          )
        else ...[
          _buildTitle(context),
          SizedBox(height: 16.h),
          _buildActionButtons(context),
        ],
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.only(right: context.isDesktop ? 120.w : 0),
          child: Text(
            course.description.isNotEmpty
                ? course.description
                : context.tr('course_desc_placeholder'),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              _buildInfoBadge(
                context,
                Icons.category_outlined,
                "${context.tr('category_label')} ${context.tr(course.category)}",
              ),
              SizedBox(width: 24.w),
              _buildInfoBadge(
                context,
                Icons.signal_cellular_alt,
                "${context.tr('level_label')} ${context.tr(course.level.toLowerCase())}",
              ),
              SizedBox(width: 24.w),
              _buildInfoBadge(
                context,
                Icons.payments_outlined,
                "${context.tr('price_label')}: ${course.price} ${context.tr('EGP')}",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final isActive = course.isActive;
    return Row(
      children: [
        Icon(
          isActive ? Icons.check_circle_outline : Icons.error_outline,
          size: 16.sp,
          color: isActive
              ? context.colorScheme.secondary
              : context.colorScheme.error,
        ),
        SizedBox(width: 4.w),
        Text(
          context.tr(isActive ? 'active' : 'inactive'),
          style: context.textTheme.labelMedium?.copyWith(
            color: isActive
                ? context.colorScheme.secondary
                : context.colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            course.title.isNotEmpty
                ? course.title
                : context.tr('course_title_placeholder'),
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: context.isDesktop ? null : 20.sp,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeaderButton(context, context.tr('edit_details'), false, () {
          final courseDetailsBloc = context.read<CourseDetailsBloc>();
          showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
              value: courseDetailsBloc,
              child: EditCourseDialog(course: course),
            ),
          );
        }),
      ],
    );
  }

  List<Widget> _buildStats(BuildContext context, CourseStatsState state) {
    if (state is CourseStatsLoaded) {
      return [
        _StatItem(
          icon: Icons.star,
          label: context.tr('ratings_count'),
          value: course.ratingsCount.toString(),
          color: Colors.amber.shade50,
          iconColor: Colors.amber,
        ),
        _StatItem(
          icon: Icons.assignment,
          label: context.tr('avg_rating'),
          value: course.avgRating.toString(),
          color: Colors.purple.shade50,
          iconColor: Colors.purple,
        ),
        _StatItem(
          icon: Icons.folder,
          label: context.tr('materials'),
          value: state.courseStats.totalMaterials.toString(),
          color: Colors.orange.shade50,
          iconColor: Colors.orange,
        ),
        _StatItem(
          icon: Icons.people,
          label: context.tr('students_enrolled'),
          value: state.courseStats.totalStudents.toString(),
          color: Colors.green.shade50,
          iconColor: Colors.green,
        ),
      ];
    }
    return [
      _StatItem(
        icon: Icons.star,
        label: context.tr('ratings_count'),
        value: course.ratingsCount.toString(),
        color: Colors.amber.shade50,
        iconColor: Colors.amber,
      ),
      _StatItem(
        icon: Icons.assignment,
        label: context.tr('avg_rating'),
        value: course.avgRating.toString(),
        color: Colors.purple.shade50,
        iconColor: Colors.purple,
      ),
      _StatItem(
        icon: Icons.folder,
        label: context.tr('materials'),
        value: "0",
        color: Colors.orange.shade50,
        iconColor: Colors.orange,
      ),
      _StatItem(
        icon: Icons.people,
        label: context.tr('students_enrolled'),
        value: "0",
        color: Colors.green.shade50,
        iconColor: Colors.green,
      ),
    ];
  }

  Widget _buildHeaderButton(
    BuildContext context,
    String text,
    bool isPrimary,
    VoidCallback onTap, {
    IconData? icon,
  }) {
    return SizedBox(
      height: 48.h,
      child: isPrimary
          ? CustomPrimaryButton(
              onTap: onTap,
              text: text,
              prefixIcon: icon != null
                  ? Icon(icon, size: 18.sp, color: context.colorScheme.surface)
                  : null,
              width: 140.w,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(
                Icons.edit_outlined,
                size: 18.sp,
                color: context.colorScheme.onSecondary,
              ),
              label: Text(
                text,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.secondary,
                foregroundColor: context.colorScheme.onSecondary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
            ),
    );
  }

  Widget _buildInfoBadge(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color iconColor;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: context.isDesktop ? 150.w : 140.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Text(
                value,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
