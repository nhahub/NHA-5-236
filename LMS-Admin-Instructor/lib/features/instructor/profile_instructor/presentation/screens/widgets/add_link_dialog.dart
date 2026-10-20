import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/theme/app_assets.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/data/models/create_link_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_state.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/domain/entity/instructor_profile_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/data/models/update_link_request_model.dart';

class AddLinkDialog extends StatefulWidget {
  final String slug;
  final InstructorLinkUIModel? existingLink;

  const AddLinkDialog({super.key, required this.slug, this.existingLink});

  @override
  State<AddLinkDialog> createState() => _AddLinkDialogState();
}

class _AddLinkDialogState extends State<AddLinkDialog> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _otherPlatformController = TextEditingController();

  String _selectedPlatform = 'facebook';
  final List<String> _platforms = [
    'facebook',
    'linkedin',
    'twitter',
    'instagram',
    'youtube',
    'github',
    'tiktok',
    'whatsapp',
    'website',
    'other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingLink != null) {
      _urlController.text = widget.existingLink!.url;
      final platform = widget.existingLink!.platformName.toLowerCase();
      if (_platforms.contains(platform)) {
        _selectedPlatform = platform;
      } else {
        _selectedPlatform = 'other';
        _otherPlatformController.text = widget.existingLink!.platformName;
      }
    }
  }

  Color? _getPlatformColor(String platform) {
    switch (platform) {
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'linkedin':
      case 'instagram':
        return null;
      case 'youtube':
        return const Color(0xFFFF0000);
      case 'github':
        return const Color(0xFF181717);
      case 'twitter':
        return Colors.black;
      case 'tiktok':
        return Colors.black;
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'website':
        return context.colorScheme.primary;
      default:
        return context.colorScheme.primary;
    }
  }

  Widget _getPlatformIconWidget(String platform) {
    final color = _getPlatformColor(platform);
    final size = 20.sp;

    switch (platform) {
      case 'facebook':
        return Icon(Icons.facebook, size: size, color: color);
      case 'instagram':
        return SvgPicture.asset(
          AppAssets.instegramIcon,
          width: size,
          height: size,
          colorFilter: color != null
              ? ColorFilter.mode(color, BlendMode.srcIn)
              : null,
        );
      case 'youtube':
        return Icon(Icons.play_circle_fill, size: size, color: color);
      case 'twitter':
        return Icon(Icons.close, size: size, color: color);
      case 'linkedin':
        return SvgPicture.asset(
          AppAssets.linkedInIcon,
          width: size,
          height: size,
          colorFilter: color != null
              ? ColorFilter.mode(color, BlendMode.srcIn)
              : null,
        );
      case 'github':
        return SvgPicture.asset(
          AppAssets.githubIcon,
          width: size,
          height: size,
          colorFilter: color != null
              ? ColorFilter.mode(color, BlendMode.srcIn)
              : null,
        );
      case 'tiktok':
        return Icon(Icons.music_note, size: size, color: color);
      case 'whatsapp':
        return Icon(Icons.chat, size: size, color: color);
      case 'website':
        return Icon(Icons.language, size: size, color: color);
      default:
        return Icon(Icons.link, size: size, color: color);
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _otherPlatformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileInstructorBloc, ProfileInstructorState>(
      listener: (context, state) {
        if (state is AddInstructorLinkSuccess ||
            state is UpdateInstructorLinkSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state is UpdateInstructorLinkSuccess
                    ? context.tr('link_updated_success')
                    : context.tr('link_added_success'),
              ),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.read<ProfileInstructorBloc>().add(
            GetProfileInstructorEvent(slug: widget.slug),
          );
          context.pop();
        } else if (state is AddInstructorLinkError ||
            state is UpdateInstructorLinkError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state is UpdateInstructorLinkError
                    ? state.message
                    : (state as AddInstructorLinkError).message,
              ),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: context.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Container(
          width: context.isMobile ? double.infinity : 450.w,
          padding: EdgeInsets.all(context.isMobile ? 24.w : 32.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primaryContainer
                              .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          widget.existingLink != null ? Icons.edit : Icons.link,
                          color: context.colorScheme.primary,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        widget.existingLink != null
                            ? context.tr('update_link')
                            : context.tr('add_link'),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  Text(
                    context.tr('platform_label'),
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceVariant.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: context.colorScheme.outline.withValues(
                          alpha: 0.1,
                        ),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPlatform,
                        isExpanded: true,
                        dropdownColor: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16.r),
                        items: _platforms.map((String platform) {
                          return DropdownMenuItem<String>(
                            value: platform,
                            child: Row(
                              children: [
                                _getPlatformIconWidget(platform),
                                SizedBox(width: 12.w),
                                Text(
                                  context.tr(platform),
                                  style: context.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedPlatform = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),

                  if (_selectedPlatform == 'other') ...[
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      txt: context.tr('other'),
                      hint: context.tr('platform_label'),
                      controller: _otherPlatformController,
                      validator: (value) =>
                          value!.isEmpty ? context.tr('required_field') : null,
                    ),
                  ],

                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    txt: context.tr('url_label'),
                    hint: context.tr('url_hint'),
                    controller: _urlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.tr('required_field');
                      }
                      if (!value.startsWith('http')) {
                        return context.tr('url_error_http');
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(context.tr('cancel')),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        flex: 2,
                        child:
                            BlocBuilder<
                              ProfileInstructorBloc,
                              ProfileInstructorState
                            >(
                              builder: (context, state) {
                                final isLoading =
                                    state is AddInstructorLinkLoading ||
                                    state is UpdateInstructorLinkLoading;
                                return CustomPrimaryButton(
                                  text: widget.existingLink != null
                                      ? context.tr('update')
                                      : context.tr('submit'),
                                  height: 48.h,
                                  onTap: isLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final platformName =
                                                _selectedPlatform == 'other'
                                                ? _otherPlatformController.text
                                                : _selectedPlatform;

                                            if (widget.existingLink != null) {
                                              context
                                                  .read<ProfileInstructorBloc>()
                                                  .add(
                                                    UpdateInstructorLinkEvent(
                                                      linkSlug: widget
                                                          .existingLink!
                                                          .slug,
                                                      requestModel:
                                                          UpdateLinkRequestModel(
                                                            slug: widget
                                                                .existingLink!
                                                                .slug,
                                                            platformName:
                                                                platformName,
                                                            url: _urlController
                                                                .text,
                                                          ),
                                                    ),
                                                  );
                                            } else {
                                              context
                                                  .read<ProfileInstructorBloc>()
                                                  .add(
                                                    AddInstructorLinkEvent(
                                                      slug: widget.slug,
                                                      requestModel:
                                                          CreateLinkRequestModel(
                                                            platformName:
                                                                platformName,
                                                            url: _urlController
                                                                .text,
                                                          ),
                                                    ),
                                                  );
                                            }
                                          }
                                        },
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
