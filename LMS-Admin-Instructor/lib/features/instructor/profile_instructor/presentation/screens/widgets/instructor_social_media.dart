import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/theme/app_assets.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/domain/entity/instructor_profile_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_event.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_link_dialog.dart';

class InstructorSocialMedia extends StatelessWidget {
  final List<InstructorLinkUIModel> links;
  final String slug;
  const InstructorSocialMedia({
    super.key,
    required this.links,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.tr('social_media'),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => BlocProvider.value(
                      value: context.read<ProfileInstructorBloc>(),
                      child: AddLinkDialog(slug: slug),
                    ),
                  );
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: context.colorScheme.primary,
                  size: 24.sp,
                ),
                tooltip: context.tr('add_link'),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          if (links.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    context.tr('no_social_media_links'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.4,
                      ),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            )
          else
            Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: links
                  .map((link) => _buildSocialIcon(context, link))
                  .toList(),
            ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    InstructorLinkUIModel link,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.tr('delete_link')),
        content: Text(context.tr('delete_link_confirmation')),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(context.tr('cancel')),
          ),
          TextButton(
            onPressed: () {
              context.read<ProfileInstructorBloc>().add(
                DeleteInstructorLinkEvent(
                  linkSlug: link.slug,
                  instructorSlug: slug,
                ),
              );
              context.pop();
            },
            child: Text(
              context.tr('delete'),
              style: TextStyle(color: context.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, InstructorLinkUIModel link) {
    IconData? iconData;
    String? svgPath;
    Color? iconColor;
    final platformKey = link.platformName.toLowerCase();

    switch (platformKey) {
      case 'facebook':
        iconData = Icons.facebook;
        iconColor = const Color(0xFF1877F2);
        break;
      case 'instagram':
        svgPath = AppAssets.instegramIcon;
        break;
      case 'youtube':
        iconData = Icons.play_circle_fill;
        iconColor = const Color(0xFFFF0000);
        break;
      case 'twitter':
      case 'x':
        iconData = Icons.close;
        iconColor = Colors.black;
        break;
      case 'linkedin':
        svgPath = AppAssets.linkedInIcon;
        break;
      case 'github':
        svgPath = AppAssets.githubIcon;
        iconColor = const Color(0xFF181717);
        break;
      case 'tiktok':
        iconData = Icons.music_note;
        iconColor = Colors.black;
        break;
      case 'whatsapp':
        iconData = Icons.chat;
        iconColor = const Color(0xFF25D366);
        break;
      case 'website':
        iconData = Icons.language;
        iconColor = context.colorScheme.primary;
        break;
      default:
        iconData = Icons.link;
        iconColor = context.colorScheme.primary;
    }

    final List<String> predefined = [
      'facebook',
      'linkedin',
      'twitter',
      'instagram',
      'youtube',
      'github',
      'tiktok',
      'whatsapp',
      'website',
    ];
    final String displayName = predefined.contains(platformKey)
        ? context.tr(platformKey)
        : link.platformName;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () async {
            final url = Uri.parse(link.url);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
          child: SizedBox(
            width: 80.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 54.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    color: iconColor!=null? iconColor.withValues(alpha: 0.1):
                    context.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: svgPath != null
                        ? SvgPicture.asset(
                            svgPath,
                            colorFilter: iconColor != null
                                ? ColorFilter.mode(
                                    iconColor,
                                    BlendMode.srcIn,
                                  )
                                : null,
                            width: 26.sp,
                            height: 26.sp,
                          )
                        : Icon(
                            iconData ?? Icons.link,
                            color: iconColor,
                            size: 26.sp,
                          ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  displayName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          right: -10,
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              size: 18.sp,
              color: context.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            onSelected: (value) {
              if (value == 'edit') {
                showDialog(
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: context.read<ProfileInstructorBloc>(),
                    child: AddLinkDialog(slug: slug, existingLink: link),
                  ),
                );
              } else if (value == 'delete') {
                _showDeleteConfirmation(context, link);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(context.tr('edit')),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 16.sp,
                      color: context.colorScheme.error,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      context.tr('delete'),
                      style: TextStyle(color: context.colorScheme.error),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
