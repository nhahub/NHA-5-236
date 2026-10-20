import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class CustomInstructorInformationDisktop extends StatefulWidget {
  final String name;
  final String description;
  final String image;
  final String slug;
  const CustomInstructorInformationDisktop({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    required this.slug,
  });

  @override
  State<CustomInstructorInformationDisktop> createState() =>
      _CustomInstructorInformationDisktopState();
}

class _CustomInstructorInformationDisktopState
    extends State<CustomInstructorInformationDisktop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 125.w,
          height: 125.h,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CustomImage(
            imagePath: widget.image,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        SizedBox(width: 24.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Instructor /",
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: " Details",
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.name, style: context.textTheme.headlineLarge),

            Row(
              children: [
                SizedBox(
                  width: 300.w, // عرض محدد للنص
                  child: Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 400.w),
                SizedBox(
                  width: 200.w,
                  // height: 55.h,
                  child: CustomPrimaryButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      backgroundColor: context.colorScheme.error,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<InstructorAdminBloc>(),
                          child: AlertDialog(
                            title: const Text("Delete Account"),
                            content: const Text(
                              "Are you sure you want to delete this instructor account?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                  context.read<InstructorAdminBloc>().add(
                                    DeleteInstructorEvent(slug: widget.slug),
                                  );
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: context.colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    text: "Delete Account",
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
